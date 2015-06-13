function printDiv(divID) {
    //Get the HTML of div
    var divElements = document.getElementById(divID).innerHTML;
    //Get the HTML of whole page
    var oldPage = document.body.innerHTML;
    var newstr = document.all.item(divID).innerHTML;
    //Reset the page's HTML with div's HTML only
    document.body.innerHTML = "<html><head><title></title></head><body>" + newstr + "</body>";
    window.open("", "_blank", "k");
    //Print Page
    // w.document.write("<html><head><title></title></head><body>" + newstr + "</body>");
    window.print();

    //Restore orignal HTML
    document.body.innerHTML = oldPage;

    //disable postback on print button
    return false;
}

var gAutoPrint = true;
function processPrint(printpage) {

    if (document.getElementById != null) {
        var html = '<HTML>\n<HEAD>\n';
        if (document.getElementsByTagName != null) {
            var headTags = document.getElementsByTagName("head");
            if (headTags.length > 0) html += headTags[0].innerHTML;
        }

        html += '\n</HE' + 'AD>\n<BODY>\n';
        var printReadyElem = document.getElementById(printpage);

        if (printReadyElem != null) html += printReadyElem.innerHTML;
        else {
            alert("Error, no contents.");
            return;
        }

        html += '\n</BO' + 'DY>\n</HT' + 'ML>';
        var printWin = window.open("", "processPrint");
        printWin.document.open();
        printWin.document.write(html);
        printWin.document.close();

        if (gAutoPrint) printWin.print();
    } else alert("Browser not supported.");

}
function processPrint_list(printpage) {

    if (document.getElementById != null) {
        var html = '<HTML>\n<HEAD>\n';
        if (document.getElementsByTagName != null) {
            var headTags = document.getElementsByTagName("head");
            if (headTags.length > 0) html += headTags[0].innerHTML;
        }

        html += '\n</HE' + 'AD>\n<BODY>\n';
        var printReadyElem = document.getElementById(printpage);

        if (printReadyElem != null) html += printReadyElem.innerHTML;
        else {
            alert("Error, no contents.");
            return;
        }

        html += '\n</BO' + 'DY>\n</HT' + 'ML>';
        var printWin = window.open("", "processPrint");
        printWin.document.open();
        printWin.document.write(html);
        printWin.document.close();

        if (gAutoPrint) printWin.print();
    } else alert("Browser not supported.");

}
function goBack() {
    window.history.go(-1)
}
function reloadpage() {
    window.location.reload();
}
//Regular Expression ex : 
//int : onkeypress="return ValidateKeypress(/\d/,event);"
//|	đại diện cho vế trước hoặc vế sau
//.	đại diện cho ký tự bất kỳ
//\w	đại diện cho ký tự chữ cái
//\d	đại diện cho ký tự số
//[0-9]	đại diện cho các số 0 đến 9
//[abc]	đại diện cho các chữ cái a hoặc b hoặc c
//?	số lần lặp lại từ 0 đến 1 lần
//*	số lần lặp lại từ 0 đến nhiều lần
//+	số lần lặp lại từ 1 đến nhiều lần
//{9}	số lần lặp lại 9 lần
//{3,4}	số lần lặp lại 3 đến 4 lần
function ValidateKeypress(numcheck, e) {
    var keynum, keychar, numcheck;
    if (window.event) {//IE
        keynum = e.keyCode;
    }
    else if (e.which) {// Netscape/Firefox/Opera
        keynum = e.which;
    }
    if (keynum == 8 || keynum == 127 || keynum == null || keynum == 9 || keynum == 0 || keynum == 13) return true;
    keychar = String.fromCharCode(keynum);
    var result = numcheck.test(keychar);
    return result;
}
//ex decimal: onkeypress="return digits(this, event, true, true);"
function digits(obj, e, allowDecimal, allowNegative) {
    var key;
    var isCtrl = false;
    var keychar;
    var reg;
    if (window.event) {
        key = e.keyCode;
        isCtrl = window.event.ctrlKey
    }
    else if (e.which) {
        key = e.which;
        isCtrl = e.ctrlKey;
    }
    if (isNaN(key)) return true;
    keychar = String.fromCharCode(key);
    // check for backspace or delete, or if Ctrl was pressed
    if (key == 8 || isCtrl) {
        return true;
    }
    reg = /\d/;
    var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
    var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;
    return isFirstN || isFirstD || reg.test(keychar);
}
function print_grv() {

    if (document.getElementById != null) {
        var html = '<HTML>\n<HEAD>\n';
        if (document.getElementsByTagName != null) {
            var headTags = document.getElementsByTagName("head");
            if (headTags.length > 0) html += headTags[0].innerHTML;
        }

        html += '\n</HE' + 'AD>\n<BODY>\n';
        var titleID = document.getElementById("title_grv");
        var printReadyElem = document.getElementById("print_table");
        if (printReadyElem != null) {
            html += titleID.innerHTML;
            html += printReadyElem.innerHTML;
        }
        else {
            alert("Error, no contents.");
            return;
        }

        html += '\n</BO' + 'DY>\n</HT' + 'ML>';
        var printWin = window.open("", "processPrint");
        printWin.document.open();
        printWin.document.write(html);
        printWin.document.close();

        if (gAutoPrint) printWin.print();
    } else alert("Browser not supported.");

}


