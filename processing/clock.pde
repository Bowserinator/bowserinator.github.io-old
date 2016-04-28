//WIP
//Add custom selection for day

Timer hoursEnd, minutesEnd, secondsEnd;
SchoolEnd school;

int sizeX, sizeY;
int state = 0; // 0 = school countdown
int m,h,s,result;
classroom classr;

void setup(){
 // size(window.innerWidth,window.innerHeight);
  size(window.innerWidth, window.innerHeight);
  sizeX = window.innerWidth;
  sizeY = window.innerHeight;
  
  hoursEnd = new Timer(color(100,255,0),60,sizeX*0.18,sizeX*0.15,sizeY*0.5,"Hours");
  minutesEnd = new Timer(color(255,100,0),60,sizeX*0.18,sizeX*0.38,sizeY*0.5,"Minutes"); //color(255,100,0)
  secondsEnd = new Timer(color(0,100,255),1000,sizeX*0.18,sizeX*0.62,sizeY*0.5,"Seconds");
  millisEnd = new Timer(color(255,255,0),100,sizeX*0.18,sizeX*0.85,sizeY*0.5,"Milliseconds");
  school = new SchoolEnd();
  classr = new classroom();
}

void draw(){
  background(30);
  
  
  //Temp for now
  if(state == 0){    //ScHOOL COUNTDOWN DEFAULT
    Date now = new Date();
    textAlign(CENTER,TOP); 
    textSize(sizeX/20); fill(200);
    text("School Countdown Timer",sizeX/2,0);
    textSize(sizeX/50); 
    text("(Times are only accurate within 10 seconds)",sizeX/2,sizeX/20);
    
    pushMatrix(); translate(0,-0.15*sizeY);
    
    textSize(sizeX/50); fill(200);
    text(now,sizeX/2,sizeY*0.77);
    text("Real time: "+realTime() + "  School Time: " + school.schoolTime(),sizeX/2,sizeY*0.79+sizeX/100);
    text("Today is an " + classr.getDay() + " day and the schedule is "+classr.getSchedule(),sizeX/2,sizeY*0.85);
    //text("Today's block schedule is [NOT HERE]",sizeX/2,sizeY*0.94);
    textSize(sizeX/30); fill(255);
    text("Time till class starts/ends: " + classr.timeTillClass(school) ,sizeX/2,sizeY*0.9);
    
    result = school.getTimeRemaining();
    h = floor(result/3600); m = floor((result - h*3600)/60); s = result - m*60 - h*3600;
    hoursEnd.draw(m,h);
    minutesEnd.draw(s,m);
    secondsEnd.draw(now.getMilliseconds(),s);
    if (result > 0){  millisEnd.draw(now.getMilliseconds(),1000-now.getMilliseconds()); }
    else{  millisEnd.draw(now.getMilliseconds(),0); }
    
    //DRAW PERCENT BAR
    fill(20);
    rect(sizeX*0.05,sizeY*0.755,sizeX*0.9,sizeY*0.01);
    if (!(m == 0 && s == 0 && h==0)){ 
      fill(255,50,0); textSize(sizeY*0.04);
      rect(sizeX*0.05,sizeY*0.755,sizeX*0.9 * (school.getPercentDone()),sizeY*0.01);
      text(int(school.getPercentDone()*100)+"%",sizeX*0.5,sizeY*0.73);
    }else{
      fill(255,50,0); textSize(sizeY*0.04);
      rect(sizeX*0.05,sizeY*0.755,sizeX*0.9 ,sizeY*0.01);
      text(int(100)+"%",sizeX*0.5,sizeY*0.73);
    }
    popMatrix();
  }
}

class Timer{
  float total,r,x,y;
  color c; String label;
  Timer(color c1, float total1,float r1,float x1,float y1,String label1){
    total = total1; c = c1; r = r1; x = x1; y = y1; label = label1;
  }
  
  void draw(float time,float displayTime){
    noStroke(); fill(50);
    ellipse(x,y,r,r);
    fill(25);
    ellipse(x,y,r*0.95,r*0.95);
    if (displayTime > 0){
      beginShape(); fill(c); 
      for(float i=0;i<TWO_PI*(time/total);i+=0.01){
        vertex(x + cos(i)*r*0.95/2, y + sin(i)*r*0.95/2);
      }vertex(x,y);
      endShape();
    }
    fill(30);
    ellipse(x,y,r*0.9,r*0.9);
    
    fill(255); textAlign(CENTER,CENTER);
    String t; textSize(r*2/5);
    if(displayTime < 10){t = "0"+int(displayTime);}
    else{t= ""+int(displayTime);}
    text(t,x,y); textSize(r*2/16);
    fill(c);
    text(label,x,y + r*0.25);
  }
}

class SchoolEnd{
  Day[] noschool = {new Day(9,7,5), new Day(9,14,5), new Day(9,23,5), new Day(10,12,5), new Day(11,5,5), new Day(11,6,5), new Day(11,26,5), new Day(11,27,5), new Day(12, 24,5),new Day(12, 25,5),new Day(12, 26,5),new Day(12, 27,5),new Day(12, 28,5),new Day(12, 29,5),new Day(12, 30,5),new Day(12, 31,5), new Day(1, 1,5),new Day(1, 2,5),new Day(1, 3,5),new Day(1, 4,5), new Day(1,18,5), new Day(2,15,5), new Day(2,16,5), new Day(4,11,5),new Day(4,12,5),new Day(4,13,5),new Day(4,14,5),new Day(4,15,5),new Day(5,30,5)};
  Day[] singleday = {new Day(11,25,5), new Day(12,23,5),new Day(1,29,5), new Day(2,24,5)};
  Day[] midterm = {new Day(2,1), new Day(2,2), new Day(2,3), new Day(2,4)};
  const TIMESHIFT = 185; //used to be 179
  
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

class classroom{
    String days = {"1,2,3|6,7,8","2,3,4|8,5,6","3,4,1|8,5,6","4,1,2|5,6,7","1,2,3,4|5,6,7,8","1,2,3,4|5,6,7,8","EXAM,EXAM"}; 
    //0 = A day, 1 = B day etc..5 = half day, 6 =midterm, 7 = PARCC?
    String parcc_days = {"PARCC,1|2,5,6","PARCC,3|4,7,8","PARCC,2|1,5,6","PARCC,4|3,7,8",
    "PARCC,1|2,5,6","PARCC,3|4,7,8","PARCC,1,2,3,4,5,6,7,8"}; //Parcc day schedule :(
    String day_name = {"A","B","C","D","E","half day","midterm","modified"};
    
    //Day types: 0 = A, 5 = half day, 6= midterm, 7 = MODIFIED SCHEDULE
    Day[] parcc = {new Day(4,19,7), new Day(4,20,7), new Day(4,21,7), new Day(4,22,7), new Day(4,27,7), new Day(4,28,7), new Day(4,29,7)};
    Day[] exceptions = {new Day(9,8,4), new Day(9,10,4), new Day(9,11,4), new Day(9,18,0), new Day(9,25,0), new Day(10,14,7), new Day(10,15,7),
    new Day(10,16,0), new Day(11,2,4), new Day(11,3,4), new Day(11,4,4), new Day(12,21,4), new Day(12,22,4),
    new Day(1,22,0), new Day(2,17,4),new Day(2,18,4),new Day(2,19,4), 
    new Day(4,19,7), new Day(4,20,7), new Day(4,21,7), new Day(4,22,7), new Day(4,25,4), new Day(4,26,4),
    new Day(4,27,7), new Day(4,28,7), new Day(4,29,7), new Day(5,16,7),  new Day(5,17,7),  new Day(5,18,7),
    new Day(6,3,0), new Day(6,13,4), new Day(6,14,4), new Day(6,15,4), new Day(6,16,4), new Day(6,17,4), 
    //Single session new Days
    new Day(11,25,5), new Day(12,23,5), new Day(1,29,5), new Day(2,24,5),
    //Midterms
    new Day(2,1,6), new Day(2,2,6), new Day(2,3,6), new Day(2,4,6),
    };
    
    Day[] noschool = {new Day(9,7,5), new Day(9,14,5), new Day(9,23,5), new Day(10,12,5), new Day(11,5,5), new Day(11,6,5), new Day(11,26,5), new Day(11,27,5), new Day(12, 24,5),new Day(12, 25,5),new Day(12, 26,5),new Day(12, 27,5),new Day(12, 28,5),new Day(12, 29,5),new Day(12, 30,5),new Day(12, 31,5), new Day(1, 1,5),new Day(1, 2,5),new Day(1, 3,5),new Day(1, 4,5), new Day(1,18,5), new Day(2,15,5), new Day(2,16,5), new Day(4,11,5),new Day(4,12,5),new Day(4,13,5),new Day(4,14,5),new Day(4,15,5),new Day(5,30,5)};
    
    //Yay finally school times
    ClassTime[][] classes = { 
        {new ClassTime({27900, 31380}), new ClassTime({31620,35100}), new ClassTime({35340,38820}), new ClassTime({38820,42420}), new ClassTime({42420,45900}), new ClassTime({46140,49620}), new ClassTime({49860,53340}) },  //A days
        {new ClassTime({27900, 31380}), new ClassTime({31620,35100}), new ClassTime({35340,38820}), new ClassTime({38820,42420}), new ClassTime({42420,45900}), new ClassTime({46140,49620}), new ClassTime({49860,53340}) },  //B days
        {new ClassTime({27900, 31380}), new ClassTime({31620,35100}), new ClassTime({35340,38820}), new ClassTime({38820,42420}), new ClassTime({42420,45900}), new ClassTime({46140,49620}), new ClassTime({49860,53340}) },  //C days
        {new ClassTime({27900, 31380}), new ClassTime({31620,35100}), new ClassTime({35340,38820}), new ClassTime({38820,42420}), new ClassTime({42420,45900}), new ClassTime({46140,49620}), new ClassTime({49860,53340}) },  //D days
        {new ClassTime({27900, 30200}), new ClassTime({30720,33300}), new ClassTime({33540,36120}), new ClassTime({36360,38940}), new ClassTime({38940,42300}), new ClassTime({42300,44880}), new ClassTime({45120,47700}), new ClassTime({47940,50520}), new ClassTime({50760,53340}) }, //E day
        {new ClassTime({27900, 29700}), new ClassTime({29880,31680}), new ClassTime({31860,33660}), new ClassTime({33840,35640}), new ClassTime({35820,34020}), new ClassTime({34200,39600}), new ClassTime({39780,41580}), new ClassTime({41760,43560}) }, //Half day
        {new ClassTime({28800, 36000}), new ClassTime({37800,45000}) } //Midterm days lol
    };
    
    ClassTime[] parcc_day_1 = {new ClassTime({27900,35100}), new ClassTime({37800,38820}), new ClassTime({38820,42420}), new ClassTime({42420,45900}), new ClassTime({46140,49620}), new ClassTime({49860,53340}) };
    Day special_parcc = new Day(4,29); //The one parcc day with periods 1-8
    ClassTime[] parcc_day_2 = {new ClassTime({27900,35100}), new ClassTime({35100,36840}), new ClassTime({37020,38760}), new ClassTime({38760,42000}), new ClassTime({42000,43740}), new ClassTime({43920,45660}), new ClassTime({45840,47580}), new ClassTime({47760,49500}), new ClassTime({49680,51420}), new ClassTime({51600,53340})  };
    
    //Fuck u processing
    Day[] singleday = {new Day(11,25,5), new Day(12,23,5),new Day(1,29,5), new Day(2,24,5)};
    Day[] midterm = {new Day(2,1), new Day(2,2), new Day(2,3), new Day(2,4)};
    
    classroom(){
    }

    
    String getSchedule(){
        for(Day i:noschool){if (month() == i.month && day() == i.day) {return "non-existant as there is no school.";}}
        int start=0;
        for(Day i:parcc){if (month() == i.month && day() == i.day) { return parcc_days[start];}start++;}
        for(Day i:exceptions){if (month() == i.month && day() == i.day) {return days[i.type];}}
        if(new Date().getDay() == 0 || new Date().getDay()==6){return "like whatever you do on break.";}
        return days[new Date().getDay()-1];
    }
    
    String getDay(){
        for(Day i:noschool){if (month() == i.month && day() == i.day) {return "no school";}}
        int start=0;
        for(Day i:parcc){if (month() == i.month && day() == i.day) {return "PARCC";}start++;}
        for(Day i:exceptions){if (month() == i.month && day() == i.day) {return day_name[i.type];}}
        if(new Date().getDay() == 0 || new Date().getDay()==6){return "weekend";}
        return day_name[new Date().getDay()-1];
    }
    
    int timeTillClass(SchoolEnd e){ //It actually returns String lolololololololol epic programming
        //If time between classes write time till class starts!
        int timeLeft = e.getTimeRemaining();
        if (timeLeft <= 0){ return "00:00:00";} //If time till school ends is 0 return 0
        if(new Date().getDay() == 0 || new Date().getDay()==6){return "00:00:00";} //Weekends = 0
      
        int i=0;
        for(Day x:singleday){ if(x.month == month() && x.day == day()){ i = 5;}}
        for(Day x:midterm){ if(x.month == month() && x.day == day()){ i = 6;}}
        for(Day x:parcc){ if (month() == x.month && day() == x.day) {i=-1;}}
                        
        if(i==0){
          i = new Date().getDay()-1; //Get a,b, ... days based on day of week
        }
        
        if (i>=0){
          for(ClassTime c: classes[i]){ //Iterate through classes of the day
            int current = hour()*3600 + minute()*60 + second() - e.TIMESHIFT;
            if (c.times[0] <= current && current <= c.times[1]){ return timeLeftToStr(c.times[1] - current);} //Get time till class ends
          }
            
          //No class matches, return time till class starts
          int timePossible = 99999999;
          for(ClassTime c: classes[i]){ //Iterate through classes of the day
            int current = hour()*3600 + minute()*60 + second() - e.TIMESHIFT;
            if (c.times[0] >= current){ 
              if(c.times[0] - current < timePossible){ timePossible = c.times[0] - current; }
            } //Get time till class ends
          }return timeLeftToStr(timePossible);
        }
        
        //It's a parcc day, use special schedule!
        if( month() == special_parcc.month && day() == special_parcc.day){ //PARcc day with periods 1-8
          for(ClassTime c: parcc_day_2){ //Iterate through classes of the day
            int current = hour()*3600 + minute()*60 + second() - e.TIMESHIFT;
            if (c.times[0] <= current && current <= c.times[1]){ return timeLeftToStr(c.times[1] - current);} //Get time till class ends
          }
          
          //No class matches, return time till class starts
          int timePossible = 99999999;
          for(ClassTime c: parcc_day_2){ //Iterate through classes of the day
            int current = hour()*3600 + minute()*60 + second() - e.TIMESHIFT;
            if (c.times[0] >= current){ 
              if(c.times[0] - current < timePossible){ timePossible = c.times[0] - current; }
            } //Get time till class ends
          }return timeLeftToStr(timePossible);
          
        }else{
          for(ClassTime c: parcc_day_1){ //Iterate through classes of the day
            int current = hour()*3600 + minute()*60 + second() - e.TIMESHIFT;
            if (c.times[0] <= current && current <= c.times[1]){ return timeLeftToStr(c.times[1] - current);} //Get time till class ends
          }
          
          //No class matches, return time till class starts
          int timePossible = 99999999;
          for(ClassTime c: parcc_day_1){ //Iterate through classes of the day
            int current = hour()*3600 + minute()*60 + second() - e.TIMESHIFT;
            if (c.times[0] >= current){ 
              if(c.times[0] - current < timePossible){ timePossible = c.times[0] - current; }
            } //Get time till class ends
          }return timeLeftToStr(timePossible);
        }
    }
    
    String timeLeftToStr(int x){
      int h = floor(x/3600);
      int m = floor((x - h*3600)/60);
      int s = x - h*3600 - m*60;
      returned = "";

      if(h<10){ returned = returned + "0"+String(h);} 
      else{ returned = returned + String(h);} 
      
      returned = returned + ":";
      
      if(m<10){ returned = returned + "0"+String(m);} 
      else{ returned = returned + String(m);} 
      returned = returned + ":";
      
      if(s<10){ returned = returned + "0"+String(s);} 
      else{ returned = returned +String(s);} 
      return returned;
    }
}

//Sigh class times are a pain :(
class ClassTime{
    float[][] times; //Array of array of times class start and end in seconds from 12:00 AM
    ClassTime(float[][] time){
        times = time;
    }
}
