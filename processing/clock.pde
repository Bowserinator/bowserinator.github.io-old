//WIP
//Add custom selection for day

Timer hoursEnd, minutesEnd, secondsEnd;
SchoolEnd school;

int sizeX, sizeY;
int state = 0; // 0 = school countdown
int m,h,s,result;

void setup(){
 // size(window.innerWidth,window.innerHeight);
  size(window.innerWidth, window.innerHeight);
  sizeX = window.innerWidth;
  sizeY = window.innerHeight;
  
  hoursEnd = new Timer(color(100,255,0),60,sizeX*0.2,sizeX*0.2,sizeY*0.5,"Hours");
  minutesEnd = new Timer(color(255,100,0),60,sizeX*0.2,sizeX*0.5,sizeY*0.5,"Minutes"); //color(255,100,0)
  secondsEnd = new Timer(color(0,100,255),100,sizeX*0.2,sizeX*0.8,sizeY*0.5,"Seconds");
  school = new SchoolEnd();
}

void draw(){
  background(30);
  
  
  //Temp for now
  if(state == 0){    //ScHOOL COUNTDOWN DEFAULT
    Date now = new Date();
    textAlign(CENTER,TOP); textSize(sizeX/50); fill(200);
    text(now,sizeX/2,sizeY*0.77);
    text("Real time: "+realTime() + "  School Time: " + school.schoolTime(),sizeX/2,sizeY*0.79+sizeX/100);
    text("WORK IN PROGRESS!!!!",sizeX/2,sizeY*0.9);
    
    result = school.getTimeRemaining();
    h = floor(result/3600); m = floor((result - h*3600)/60); s = result - m*60 - h*3600;
    hoursEnd.draw(m,h);
    minutesEnd.draw(s,m);
    secondsEnd.draw(now.getMilliseconds(),s);
     
    //DRAW PERCENT BAR
    fill(20);
    rect(sizeX*0.05,sizeY*0.755,sizeX*0.9,sizeY*0.01);
    if (!(m == 0 && s == 0 && h==0)){ 
      fill(255,50,0); textSize(sizeY*0.02); textAlign(LEFT,TOP);
      rect(sizeX*0.05,sizeY*0.755,sizeX*0.9 * (school.getPercentDone()),sizeY*0.01);
      text(int(school.getPercentDone()*100)+"%",sizeX*0.05 + sizeX*0.91,sizeY*0.75);
    }else{
      fill(255,50,0); textSize(sizeY*0.02); textAlign(LEFT,TOP);
      rect(sizeX*0.05,sizeY*0.755,sizeX*0.9 ,sizeY*0.01);
      text(int(100)+"%",sizeX*0.05 + sizeX*0.91,sizeY*0.75);
    }
  }
}

class Timer{
  float total,r,x,y;
  color c; String label;
  Timer(color c1, float total1,float r1,float x1,float y1,String label1){
    total = total1; c = c1; r = r1; x = x1; y = y1; label = label1;
  }
  
  void draw(float time,float displayTime){
    fill(50); noStroke();
    ellipse(x,y,r,r);
    if (displayTime > 0){
      beginShape(); fill(c); 
      for(float i=0;i<TWO_PI*(time/total);i+=0.01){
        vertex(x + cos(i)*r*0.95/2, y + sin(i)*r*0.95/2);
      }vertex(x,y);
      endShape();
    }
    fill(40); ellipse(x,y,r*0.9,r*0.9);
    
    fill(255); textAlign(CENTER,CENTER);
    String t; textSize(r*2/5);
    if(displayTime < 10){t = "0"+int(displayTime);}
    else{t= ""+int(displayTime);}
    text(t,x,y); textSize(r*2/16);
    text(label,x,y + r*0.25);
  }
}

class SchoolEnd{
  Day[] noschool = {new Day(9,7,5), new Day(9,14,5), new Day(9,23,5), new Day(10,12,5), new Day(11,5,5), new Day(11,6,5), new Day(11,26,5), new Day(11,27,5), new Day(12, 24,5),new Day(12, 25,5),new Day(12, 26,5),new Day(12, 27,5),new Day(12, 28,5),new Day(12, 29,5),new Day(12, 30,5),new Day(12, 31,5), new Day(1, 1,5),new Day(1, 2,5),new Day(1, 3,5),new Day(1, 4,5), new Day(1,18,5), new Day(2,15,5), new Day(2,16,5), new Day(4,11,5),new Day(4,12,5),new Day(4,13,5),new Day(4,14,5),new Day(4,15,5),new Day(5,30,5)};
  Day[] singleday = {new Day(11,25,5), new Day(12,23,5),new Day(1,29,5), new Day(2,24,5), new Day(4,26,5)};
  Day[] midterm = {new Day(2,1), new Day(2,2), new Day(2,3), new Day(2,4)};
  const TIMESHIFT = 179;
  
  SchoolEnd(){
    
  }
  
  int getTime(){
    return hour()*3600 + minute()*60 + second();
  }
  
  float getPercentDone(){
    int returned;
    for(Day i:noschool){ if(i.month == month() && i.day == day()){ return 1;} }
    
    if(14*3600 + 49*60 + TIMESHIFT >= 7*3600 + 45*60 + TIMESHIFT && 14*3600 + 49*60 + TIMESHIFT <= 14*3600 + 49*60 + TIMESHIFT){
      //Single days
      for(Day i:singleday){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 6*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 1;}
            return 1.0 - returned/(12*3600 + 6*60 - 7*3600 - 45*60);
        }
      }
      //Midterm days
      for(Day i:midterm){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 30*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 1;}
           return 1.0 - returned/(12*3600 + 30*60 - 7*3600 - 45*60);
        }
      }
      returned = 14*3600 + 49*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
      if(returned <= 0){return 1;}
      return 1.0 - returned/(14*3600 + 49*60 - 7*3600 - 45*60);
    }
    return 0;
  }
  
  String schoolTime(){
      int dif = getTime()-TIMESHIFT;
      int hour = dif / 3600; int minute = (dif - floor(hour)*3600)/60; int second = (dif - floor(hour)*3600 - floor(minute)*60);
      String h,m,s;
      hour = floor(hour); minute = floor(minute); second = floor(second);
      
      if (hour < 10){ h = "0"+hour;}
      else{h = ""+hour;}
      
      if (minute < 10){ m = "0"+minute;}
      else{m = ""+minute;}
      
      if (second < 10){ s = "0"+second;}
      else{s = ""+second;}
      return  h + ":" + m + ":" + s;
      
  }
  
  int getTimeRemaining(){ //Returns remaining time seconds
    //if day is saturday or sunday, return 0
    //if day is summer ,spring rbeak or winter break return 0
    //if day in no school return 0
    int returned;
    for(Day i:noschool){ if(i.month == month() && i.day == day()){ return 0;} }
    
    if(14*3600 + 49*60 + TIMESHIFT >= 7*3600 + 45*60 + TIMESHIFT && 14*3600 + 49*60 + TIMESHIFT <= 14*3600 + 49*60 + TIMESHIFT){
      //Single days
      for(Day i:singleday){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 6*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 0;}
           return returned;
        }
      }
      //Midterm days
      for(Day i:midterm){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 30*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 0;}
           return returned;
        }
      }
      returned = 14*3600 + 49*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
      if(returned <= 0){return 0;}
      return returned;
    }
    return 0;
 }

}

class Day{ //Type: 1 = A, 2 = B, ... 6 = half 7 = no school
  int month, day, type; 
  Day(int m,int d, int l){
    month  = m; day = d; type = l;
  }
}
String realTime(){
  String returned;
  String h,m,s;
  
  h = hour(); m = minute(); s = second();
  if(hour()<10){h = "0" + hour();}
  if(minute()<10){m = "0" + minute();}
  if(second()<10){s = "0" + second();}
  returned = h + ":"+ m + ":" + s;
  return returned;
}
