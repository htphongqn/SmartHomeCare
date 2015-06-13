using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Drawing.Text;
using System.Text;
/**
 * \brief captcha processing
 */
public class CaptchaImage
{
    /**
     * Public properties (all read-only). 
	 */ 
	public string Text
	{
		get { return this.text; }
	}
	public Bitmap Image
	{
		get { return this.image; }
	}
	public int Width
	{
		get { return this.width; }
	}
	public int Height
	{
		get { return this.height; }
	}

    /**
     * Internal properties. 
	 */ 
	private string text;
	private int width;
	private int height;
	private string familyName;
	private Bitmap image;

    /**
     * For generating random numbers. 
     */
	private Random random = new Random();
    /**
	 * Initializes a new instance of the CaptchaImage class using the
	 */
    public CaptchaImage()
    {

    }
	/**
	 * Initializes a new instance of the CaptchaImage class using the
	 * specified text, width and height.
	 */
	public CaptchaImage(string s, int width, int height)
	{
		this.text = s;
		this.SetDimensions(width, height);
		this.GenerateImage();
	}

	/**
	 * Initializes a new instance of the CaptchaImage class using the
	 * specified text, width, height and font family.
	 */
	public CaptchaImage(string s, int width, int height, string familyName)
	{
		this.text = s;
		this.SetDimensions(width, height);
		this.SetFamilyName(familyName);
		this.GenerateImage();
	}

	/**
	 * This member overrides Object.Finalize.
	 */
	~CaptchaImage()
	{
		Dispose(false);
	}

	/**
	 * Releases all resources used by this object.
	 */
	public void Dispose()
	{
		GC.SuppressFinalize(this);
		this.Dispose(true);
	}

	/**
	 * Custom Dispose method to clean up unmanaged resources.
	 */
	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
            this.image.Dispose();/** Dispose of the bitmap. */
	}

	/**
	 * Sets the image width and height.
	 */
	private void SetDimensions(int width, int height)
	{
        if (width <= 0) /** Check the width and height. */
			throw new ArgumentOutOfRangeException("width", width, "Argument out of range, must be greater than zero.");
		if (height <= 0)
			throw new ArgumentOutOfRangeException("height", height, "Argument out of range, must be greater than zero.");
		this.width = width;
		this.height = height;
	}

	/**
	 * Sets the font used for the image text.
	 */
	private void SetFamilyName(string familyName)
	{
		/** If the named font is not installed, default to a system font. */
		try
		{
			Font font = new Font(this.familyName, 12F);
			this.familyName = familyName;
			font.Dispose();
		}
		catch (Exception ex)
		{
			this.familyName = System.Drawing.FontFamily.GenericSerif.Name;
		}
	}

	/**
	 * Creates the bitmap image.
	 */
	private void GenerateImage()
	{
		/** Create a new 32-bit bitmap image. */
		Bitmap bitmap = new Bitmap(this.width, this.height, PixelFormat.Format32bppArgb);

		/** Create a graphics object for drawing.*/
		Graphics g = Graphics.FromImage(bitmap);
		g.SmoothingMode = SmoothingMode.AntiAlias;
		Rectangle rect = new Rectangle(0, 0, this.width, this.height);

        /** Fill in the background.*/
		HatchBrush hatchBrush = new HatchBrush(HatchStyle.SmallConfetti, Color.LightGray, Color.White);
		g.FillRectangle(hatchBrush, rect);

        /** Set up the text font.*/
		SizeF size;
		float fontSize = rect.Height + 1;
		Font font;
        /** Adjust the font size until the text fits within the image.*/
		do
		{
			fontSize--;
			font = new Font(this.familyName, fontSize, FontStyle.Bold);
			size = g.MeasureString(this.text, font);
		} while (size.Width > rect.Width);

        /** Set up the text format. */
		StringFormat format = new StringFormat();
		format.Alignment = StringAlignment.Center;
		format.LineAlignment = StringAlignment.Center;

        /** Create a path using the text and warp it randomly. */
		GraphicsPath path = new GraphicsPath();
		path.AddString(this.text, font.FontFamily, (int) font.Style, font.Size, rect, format);
		float v = 4F;
		PointF[] points =
		{
			new PointF(this.random.Next(rect.Width) / v, this.random.Next(rect.Height) / v),
			new PointF(rect.Width - this.random.Next(rect.Width) / v, this.random.Next(rect.Height) / v),
			new PointF(this.random.Next(rect.Width) / v, rect.Height - this.random.Next(rect.Height) / v),
			new PointF(rect.Width - this.random.Next(rect.Width) / v, rect.Height - this.random.Next(rect.Height) / v)
		};
		Matrix matrix = new Matrix();
		matrix.Translate(0F, 0F);
		path.Warp(points, rect, matrix, WarpMode.Perspective, 0F);

        /** Draw the text. */
		hatchBrush = new HatchBrush(HatchStyle.LargeConfetti, Color.LightGray, Color.DarkGray);
		g.FillPath(hatchBrush, path);

        /** Add some random noise. */
		int m = Math.Max(rect.Width, rect.Height);
		for (int i = 0; i < (int) (rect.Width * rect.Height / 30F); i++)
		{
			int x = this.random.Next(rect.Width);
			int y = this.random.Next(rect.Height);
			int w = this.random.Next(m / 50);
			int h = this.random.Next(m / 50);
			g.FillEllipse(hatchBrush, x, y, w, h);
		}

        /** Clean up. */
		font.Dispose();
		hatchBrush.Dispose();
		g.Dispose();

        /** Set the image. */
		this.image = bitmap;
	}
    /**
	 * Creates the bitmap image random text.
	 */
    public string CreateCaptcha()
    {
        const byte LENGTH = 5;
        // chiều dài chuỗi để lấy các kí tự sẽ sử dụng cho captcha
        const string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        using (Bitmap bmp = new Bitmap(120, 35))
        {
            using (Graphics g = Graphics.FromImage(bmp))
            {
                // Tạo nền cho ảnh dạng sóng
                HatchBrush brush = new HatchBrush(HatchStyle.Percent80, Color.White, Color.Tan);
                g.FillRegion(brush, g.Clip);
                // Lưu chuỗi captcha trong quá trình tạo
                StringBuilder strCaptcha = new StringBuilder();
                Random rand = new Random();
                float locationX = 3;
                for (int i = 0; i < LENGTH; i++)
                {
                    // Lấy kí tự ngẫu nhiên từ mảng chars
                    SolidBrush brushes = new SolidBrush(GetRandomColor());
                    string str = chars[rand.Next(chars.Length)].ToString();
                    strCaptcha.Append(str);
                    // Tạo font với tên font ngẫu nhiên chọn từ mảng fonts
                    Font font = new Font("Times New Roman", new Random().Next(14, 17), FontStyle.Bold);
                    // Lấy kích thước của kí tự
                    SizeF size = g.MeasureString(str, font);
                    // Vẽ kí tự đó ra ảnh tại vị trí tăng dần theo i, vị trí top ngẫu nhiên
                    g.DrawString(str, font, brushes, locationX, rand.Next(2, 10));
                    font.Dispose();
                    //định location X
                    locationX += size.Width + i;
                }
                // Lưu captcha vào session
                HttpContext.Current.Session["captcha"] = strCaptcha.ToString();
                // Ghi ảnh trực tiếp ra luồng xuất theo định dạng gif
                //Response.ContentType = "image/GIF";4
                int numRandom = new Random().Next(1, 3000);
                string imgFile = "captcha" + numRandom + ".jpg";
                string directoryCaptcha = "~/resources/images/captcha/";
                // Kiểm tra thư mục đã tồn tại
                if (!Directory.Exists(HttpContext.Current.Server.MapPath(directoryCaptcha)))
                {
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath(directoryCaptcha));
                }
                //lấy thông tin thư mục
                DirectoryInfo direcInfo = new DirectoryInfo(HttpContext.Current.Server.MapPath(directoryCaptcha));
                foreach (FileInfo file in direcInfo.GetFiles("*.jpg"))
                {
                    try
                    {
                        //Xóa tất cả các tập tin hình trong thư mục hiện tại
                        file.Delete();
                    }
                    catch { }
                }
                bmp.Save(HttpContext.Current.Server.MapPath(directoryCaptcha + imgFile));
                return directoryCaptcha + imgFile;
            }
        }
    }
    int rrandom = 0;
    int grandom = 0;
    int brandom = 0;
    /**
     * Creates the color random.
     */
    public Color GetRandomColor()
    {
        Random rnd = new Random();
        int ri = rnd.Next(255);
        if (ri == rrandom)
        {
            ri = rnd.Next(255);
        }
        else
        {
            rrandom = ri;
        }
        int gi = rnd.Next(255);
        if (gi == grandom)
        {
            gi = rnd.Next(255);
        }
        else
        {
            grandom = gi;
        }
        int bi = rnd.Next(255);
        if (bi == brandom)
        {
            bi = rnd.Next(255);
        }
        else
        {
            brandom = bi;
        }
        byte r = Convert.ToByte(ri);
        byte g = Convert.ToByte(gi);
        byte b = Convert.ToByte(bi);
        return Color.FromArgb(r, g, b);
    }
}

