var date1 = new Date("1/31/2016");
var date2 = new Date();
var timeDiff = Math.abs(date2.getTime() - date1.getTime());
var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
console.log(diffDays);
$(".foot01 span").text(diffDays);
// Add the .active class to the proper link if the URL matches
$(".menu-link").each(function() {
    if ($(this).attr("href") == location.pathname || $(this).attr("href").indexOf(location.pathname) && location.pathname != "/") {
        $(this).addClass("active");
    } else if (location.pathname == "/") {
        $(".menu-link").eq(0).addClass("active");
    }
});
