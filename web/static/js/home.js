"use strict";
$(function () {
    $("#register-btn").click("on", function () {
        window.location.href = $("#address").val()+"/free/register";
    });
    $("#login-btn").click("on", function () {
        window.location.href = $("#address").val()+"/free/login";
    });

    $("#pages_show").hover(function () {
        $("#pages").fadeIn(1100);
    },function () {
        $("#pages").fadeOut(1100);
    });
});