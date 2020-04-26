let add_showName_p;
let add_fileDesc_p;
$(function () {
    let isShowName = false;
    let isFileDesc = false;
    add_showName_p = $("#add_showName_p");
    add_fileDesc_p = $("#add_fileDesc_p");
    $("#showName").blur(function () {
        let $showName = $(this).val();

        if ($showName.length === 0) {
            //文件名不能为空
            add_showName_p.children("p").remove();
            add_showName_p.append($("<p class='text-warning text-left' style='font-size: 16px; padding-top: 4px;position:absolute;top: 20px'><span class='glyphicon glyphicon-remove-circle'></span>&nbsp;文件名不能为空！</p>"));
        } else {
            //正确
            add_showName_p.children("p").remove();
            add_showName_p.append($("<p class='text-warning text-left' style='font-size: 16px; padding-top: 4px;position:absolute;top: 20px'><span class='glyphicon glyphicon-ok-circle'></span></p>"));
            isShowName = true;
        }
    });

    $("#fileDesc").blur(function () {
        let $fileDesc = $(this).val();

        if ($fileDesc.length === 0) {
            //文件名不能为空
            add_fileDesc_p.children("p").remove();
            add_fileDesc_p.append($("<p class='text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-sign'></span>&nbsp;代码说明不可为空！</p>"));
        } else {
            add_fileDesc_p.children("p").remove();
            add_fileDesc_p.append($("<p class='text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-ok-circle'></span>&nbsp;</p>"));
            //正确
            $fileDesc = true;
        }
    });

    $("#codeEdit_submit").click(function (event) {
        if($("#showName").val().length > 0){
            isShowName = true;
        }
        if($("#fileDesc").val().length > 0){
            isFileDesc = true;
        }
        if (isShowName && isFileDesc) {
            event.preventDefault();
            $("#from_codeEdit").submit();
        } else {
            alert("请正确填写表单!");
            add_showName_p.append($("<p class='text-warning text-left' style='font-size: 16px; padding-top: 4px;position:absolute;top: 20px'><span class='glyphicon glyphicon-remove-circle'></span>&nbsp;文件名不能为空！</p>"));
            add_fileDesc_p.append($("<p class='text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-circle'></span>&nbsp;代码说明不可为空！</p>"));
        }
    });
});