
class WindSetter 
{ 
  float x0, y0;  // wheel center
  float theta=0;  // wheel orientation
  float x, y;    // wheel handle
  float wheel_r;         // wheel radius
  float handle_r=10;
  PVector handle_center=new PVector();
  boolean isOver = false; 
  boolean grip = false; 

 
  
  WindSetter(float x, float y, float r) 
  { 
    this.x0 = x;
    this.y0 = y;
    
    this.wheel_r = r;
       
  } 

  float update() 
  { 
    if (grip) { 
      
         
         theta = atan((mouseX-x0)/(mouseY-y0));
         if (mouseY<y0) theta+=PI;
         
         
             }
   
    
    if (this.over() || grip){ 
      isOver = true; 
    } else { 
      isOver = false; 
    } 
    
    return theta-PI;
  } 
  
  // Test for mouse over the handle
  boolean over() {
    handle_center.x = x0 + wheel_r*sin(theta);
    handle_center.y = y0 + wheel_r*cos(theta);
   
    PVector mouse_pos=new PVector(mouseX,mouseY);
    if  (mouse_pos.dist(handle_center)< handle_r ) {
   
      return true;
    } else {
      return false;
    }
  }

  

  void draw() 
  { 
    
    
    // the arrow
    rectMode(CENTER);
    noStroke();
    pushMatrix(); 
    translate(x0+wheel_r*sin(theta),y0+wheel_r*cos(theta));
  
    rotate(PI-theta);
    scale(0.5);
    fill(100,100,200);
    rect(0,0,10,50);
    beginShape();
    vertex(-15,20); vertex(0,45); vertex(15,20);
    
    endShape();
   
    popMatrix();
    
  
     
   
    if (grip||isOver){
        // the runner arc
      noFill();
      stroke(100);
      ellipse(x0,y0,wheel_r,wheel_r);
      // the handle
      fill(224,60,26);
      stroke(0);
      ellipse(x0+wheel_r*sin(theta),y0+wheel_r*cos(theta), handle_r, handle_r);
    }
    
    
    
  } 

  void pressed() 
  { 
    if (isOver) { 
      grip = true; 
    } else { 
      grip = false; 
    }  
  } 

  void released() 
  { 
    grip = false; 
     } 
} 
