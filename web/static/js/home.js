"use strict";
$(function () {
    $("#register-btn").click("on", function () {
        window.location.href = "register";
    });
    $("#login-btn").click("on", function () {
        window.location.href = "login";
    });

    $("#pages_show").hover(function () {
        $("#pages").fadeIn(1100);
    },function () {
        $("#pages").fadeOut(1100);
    });
});