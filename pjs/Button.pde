class CircleButton
{  
  int x, y;
  int diameter;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean mouseover = false;


CircleButton() { }

CircleButton(int x, int y, int isize, color icolor, color ihighlight) 
  {
    this.x = x;
    this.y = y;
    this.diameter = isize;
    this.basecolor = icolor;
    this.highlightcolor = ihighlight;
    this.currentcolor = icolor;
   
      }


    void draw(){ 
    
    mouseover=checkForMouseover(); 
      
      
    if(mouseover) {
      currentcolor = highlightcolor;
       } 
    else {
      currentcolor = basecolor;
      }
      
    noStroke();
    fill(currentcolor);
    ellipse(x, y, diameter, diameter);
    //fill(0);  
      
    }
    
  
    boolean checkForMouseover(){
    float disX = x - mouseX;
    float disY = y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } 
    else {
      return false;
     }
    }
  
  }

 class StartStop extends CircleButton
{  

  boolean isOn=false;
   
  StartStop(int x, int y) 
  {
    this.x = x;
    this.y = y;
    
    diameter=25;
    basecolor=color(220,190,10);
    highlightcolor=color(240,200,50);
    currentcolor=basecolor;  
      }
 
   void draw(){ 
    
   super.draw();
   fill(100);
   if (isOn) rect(x,y,7,7); else  {
      pushMatrix();
      translate(x-3,y-5);
      rotate(PI/6);
      float l=10;
      beginShape();
      vertex(0,0);
      vertex(l,0);
      vertex(l/2,l*sin(PI/3));
      endShape();
      popMatrix();
   }
   
  // image(on,x-8,y-6); else image(off,x-8,y-6); 
    }
  
}
