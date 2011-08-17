PImage frame;
WindSetter windsetter;
Fleet fleet;
//WaveCrests waves;
StartStop startstop;	
boolean running=false;

void setup() {
  size(500, 250);  
  frameRate(30);  
 // smooth();
  
  fleet=new Fleet(6);
  windsetter = new WindSetter( 250, 125,  50); 
  waves= new WaveCrests(10);
  startstop= new StartStop(440,200);
  frame = loadImage("img/frame.gif"); 
}



void draw() {

  background(170,170,250);

    waves.update();
    fleet.update(windsetter.update());
  
  
  
    waves.draw();
   fleet.draw();		 
    windsetter.draw();
  
  startstop.draw();
   image(frame,0,0);


}


void mousePressed() 
{
 
    windsetter.pressed(); 
   
    if(startstop.mouseover){
           startstop.isOn = !startstop.isOn;  
           running=startstop.isOn;
        } 
   
}

void mouseReleased() 
{
 
    windsetter.released(); 
  
}





