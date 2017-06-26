//using json get as an example, pointing at iss-pass
//using info from https://stackoverflow.com/questions/25781652/converting-epoch-time-stamp-to-readable-date-not-working
//http://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html?is-external=true
// to do count down timer , 
//print times of the passes in human readable - done 
// switch on gps locations  

import http.requests.*;
import java.text.SimpleDateFormat.*; 
import java.util.Date.*;
int begin = millis(); 
int duration = 20;
int time = 20;
int timer1;
int timetopass;

public void setup() 
{
	size(400,400);
long now = System.currentTimeMillis();
//int begin = millis();
String date = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(now));
long nowtimesec = now / 1000;

println(nowtimesec);
println(date);	
  GetRequest get = new GetRequest("http://api.open-notify.org/iss-pass.json?lat=54.978301&lon=-1.587802"); //newcastle
  get.send(); // program will wait untill the request is completed
  //println("response: " + get.getContent());

  JSONObject response = parseJSONObject(get.getContent());
  JSONArray passes = response.getJSONArray("response");
  JSONObject rise = passes.getJSONObject(1);//gets each of the passes[duration and risetime]
   println(" ");
   println("pass " + (1));
   long pass = rise.getInt("risetime");
   //println(pass);
   long pass1000=pass*1000;
   println("pass1000: " + pass1000);
   String datetime = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date(pass1000));
   println("datetime: " + datetime); 
  
   //long pass = 1000 * rise.getInt("risetime");
   //int pass = rise.getInt("risetime");
   
   //println("long pass: " + pass);
   long timetopass = (((pass1000 - now))/60000);
   println("time till next: " + timetopass + " minutes");
   //text("time till next: " + timetopass + " minutes",50,50);
   println("duration: " + (float(rise.getInt("duration"))/60) + " minutes");
   int timer1 = int(timetopass);
   println(timer1);
   timer1=timer1*60;
   
   /*
   int i=0;i<passes.size();i++
   for(int i=timer1; i>0; i--) {
     println(timer1);
     timer1=timer1-1;
     println("thisisi " + i);
   }
   */
}
void draw(){
  text("time till next: " + timetopass + " minutes",50,50);
   if (timer1 > 0){  
    time = timer1 - (millis() - begin)/1000;
    println("timer1: " + timer1);
    println("time: " + time);
    text(millis(),50,50);
    text(time, 80, 80);
   }
}
   //println("time to next rise " + rise.getInt("risetime"));  
   //println("risetime: " + rise.getInt("risetime"));
   //println(i);
  

 
 /*
int begin; 
int duration = 20;
int time = 20;

void setup() {
  size(600, 600); 
  begin = millis();   
}

void draw() {
  background(0); 
  if (time > 0){  
    time = duration - (millis() - begin)/1000;
    text(time, 80, 80);
}
*/