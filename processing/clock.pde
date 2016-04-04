//https://bowserchannelbot-bowserinator.c9users.io/Website/main.html

/*
Global Variables
*/

int currentTime=0;
int sizeX,sizeY;
int SHIFT = 178;

String txt = "Muhlenrad sie unterwegs dahinging nur dir tanzmusik plotzlich ihr. Da uberwunden neidgefuhl in nachtessen ei. So filzhut da scheint zu standen geruckt bruchig. Tor bosheit schonen tat bis klopfen wie zuhorte brachte. Ubelnehmen messingnen die aufmerksam augenblick gearbeitet das. Es getraumt befehlen an wu schmalen spateren geholfen zu. Es horen hinab kinde fu zu stand sitte. Den jenseits ehe tal gerberei ist lampchen. Darum herum woher ruhig sie tun weg ferne lernt gut. Gehort gesund harten luftig so wochen bandes fu ab. Bi behalten se ab begehrte schreibt da. Was sicher auf lassig sommer des ich. Zeigte ungern sirach lauter zur knarre ten drohte ihr man. Du nichtstun zufrieden bekannten pa wu hauswesen. Ort nur endigend erzahlte spielend hausherr ihr schmales tadellos. Wu preisen so pa argerte gefallt wahrend schonen. Neu ich merken lieber nur lebtag lehnte. Nun gedacht gelernt ich spielte glatten gerbers. So es fest denn kann sein welt. Storen uhr vom handen sei soviel ich minder. Heut fur ehe lie warm aber weg. Jahre von und bette wer kommt tur. Je wobei tiefe um am suppe danke. Gelben fallen ei seinem du sorgen. Gut stehen knarre morgen hei bat. See ordnen ort hol neu brauen solche. Ewige krank bei kalte neu sehet unter. Geschickt das unendlich hol geblieben den grasplatz. Nah wir die ungerechte sonderling halboffene wohlgefuhl flusterton. Umwolkt je spielen sa sondern ab. Laufet ein laufen jemals hob kugeln leuten stehen. Da sich wert in sohn. Da da wies alte igen er bald. Gro sudwesten viehmarkt weg sah stadtchen schnupfen. Sauber mit morgen weg frauen ihm. Ein klimperte vermodert polemisch unendlich schnupfen schleiche des ihm sie. Spiel sahen das fur viele sonst leben leuen. Pa vermodert schwemmen gegenteil wo zerfasert. Wunderbar in schwemmen grundlich belustigt turnhalle im behaglich. Ihre hell paar froh kerl weg man buch. Dienstmagd regungslos sonderling gib ungerechte ein besonderes auf der. Anrufen em instand nachdem kindern meister mu niemand am da. Gewandert schwachen man schlupfte wie geschickt ich sog. Wo bewirtung zerfasert so kraftiger handwerke ri la kindliche. Tage ja grad so mann. Gut gerberei bis gefallen arbeiter. Nun tat kostet lebtag gefegt konnen treppe laufet. Da schwarzes bewirtung ja so barbieren da. Augenblick auf hoffnungen nachtessen bilderbuch von aufmerksam todesfalle. Hoch ja ihre ab kerl en hatt uben. Sprechen gekommen allerlei lachelte blo gab sprachen gefallen. Horchend schreibt schaffte das blaulich sog hof nie. So wo stelle labsal worden du hockte in schade. Sa mu storen du rechte diesen strich nimmer ziegen. Bezahlen mehrmals zunachst ins spielend wie schlafet. Ausblasen wer auf sei neugierig geschickt und. Verlassen gegenuber und vergesset ich gegriffen ausgeruht aus. Mi gemessen gewartet verwohnt sa funkelte schlafen in. Neues sei indes takte sehen hob gru wovon weg. So am um nichts konnen sommer. Mehr wert ganz du doch je froh uber. Ins herkommen fur behaglich schreiben das kammertur vermodert. Des hufschmied vor eigentlich als bodenlosen was. Zusammen fur kindbett war geworden lockigen befehlen. Brauchen flu blattern vor sorglich marschen nun richtete. Brotkugeln der wie vorsichtig ein ist geschlafen. Zitterte sah hinunter weg sog konntest gelernte schuftet. Sauberlich nachmittag sto landsleute ungerechte lehrlingen gro all. Stelle als fertig beugte allein blo. Ei tate stie fiel wies chen ja es. Hatten gruben hob kostet zur sofort las ins. Du ob achtete im da solange stellte ordnung standen. Bummelte se spateren vorwarts so wo heiraten. Die weiterhin verweilen einfacher duftenden bei geh musterung. Einfach fremder uhr gefreut saubere gru antwort ten die. Als weiblein lampchen schlafer burschen das wohlfeil gut art. Fast kaum tut aber auch hoch nie dort. Gerochen ihr schlafet tat ein gerberei wunschte ehe vollbart blattern. Wieder ri um gelang feinen keinem in bi. Ebenso he ja lebtag vorbei da. Halboffene da achthausen vorsichtig bi du gerbersteg. Schaute klopfte zwingen gelernt mit unrecht auffiel bei. See verlohnt getraumt wer begegnen sto spateren sorgfalt. ";
txt = txt+txt+txt+txt+txt;

int getTime(){
    return hour()*3600 + minute()*60 + second();
}

String subTime(){
    int dif = 14*3600 + 60*49 + SHIFT - getTime();
    int hour = dif / 3600; int minute = (dif - floor(hour)*3600)/60; int second = (dif - floor(hour)*3600 - floor(minute)*60);
    hour = floor(hour); minute = floor(minute); second = floor(second);
    String h,m,s;
    
    if (hour < 10){ h = "0"+hour;}
    else{h = ""+hour;}
    
    if (minute < 10){ m = "0"+minute;}
    else{m = ""+minute;}
    
    if (second < 10){ s = "0"+second;}
    else{s = ""+second;}
    return h + ":" + m + ":" + s;
    
}

String getTime2(){
    int dif = getTime();
    int hour = dif / 3600; int minute = (dif - floor(hour)*3600)/60; int second = (dif - floor(hour)*3600 - floor(minute)*60);
    String h,m,s;
    hour = floor(hour); minute = floor(minute); second = floor(second);
    
    if (hour < 10){ h = "0"+hour;}
    else{h = ""+hour;}
    
    if (minute < 10){ m = "0"+minute;}
    else{m = ""+minute;}
    
    if (second < 10){ s = "0"+second;}
    else{s = ""+second;}
    return "Real time: " + h + ":" + m + ":" + s;
    
}

String getTime3(){
    int dif = getTime()-SHIFT;
    int hour = dif / 3600; int minute = (dif - floor(hour)*3600)/60; int second = (dif - floor(hour)*3600 - floor(minute)*60);
    String h,m,s;
    hour = floor(hour); minute = floor(minute); second = floor(second);
    
    if (hour < 10){ h = "0"+hour;}
    else{h = ""+hour;}
    
    if (minute < 10){ m = "0"+minute;}
    else{m = ""+minute;}
    
    if (second < 10){ s = "0"+second;}
    else{s = ""+second;}
    return "School time: " + h + ":" + m + ":" + s;
    
}

void setup(){
    size(window.innerWidth, window.innerHeight);
    sizeX = window.innerWidth/2;
    sizeY = window.innerHeight/2;
    
}

void draw(){
    background(255); 
    textAlign(LEFT,TOP); fill(245); textLeading(10);
    text(txt,0,0,sizeX*8,sizeY*8);
    
    fill(0); textSize(140); textAlign(CENTER,CENTER);
    if (getTime() >= 14*3600+49*60+SHIFT || getTime() <= 7*3600+45*60+SHIFT){
        text("00:00:00",sizeX,sizeY*0.8);
        textSize(40);
        text("School is over!",sizeX,sizeY*1.1);
    }else{
        text(subTime(),sizeX,sizeY*0.8);
        textSize(40);
        text("School is in session :C",sizeX,sizeY*1.1);
    }
    text(getTime2(),sizeX,sizeY*1.2);
    text(getTime3(),sizeX,sizeY*1.3);
}
