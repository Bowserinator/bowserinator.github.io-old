var date1 = new Date("1/31/2016");
var date2 = new Date();
var timeDiff = Math.abs(date2.getTime() - date1.getTime());
var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
console.log(diffDays)
document.getElementsByClassName("foot01").innerHTML =
"<p>Currently  " + diffDays + " days have passed since the website first came up!.</p>";

document.getElementsByClassName("nav01").innerHTML =
"<ul id='menu'>" +
"<li><a href='index.html'>Home</a></li>" +
"<li><a href='irc.html'>IRC</a></li>" +
"<li><a href='about.html'>About</a></li>" +
"</ul>";
