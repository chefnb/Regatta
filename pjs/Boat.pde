class Boat{
 Fleet p;
 PVector coords;
 int reg_no;
 float heading;
 float sail_angle;
 float speed=0.8;
 PVector heading_vector;
 float sigma=30; // avoidance core
 float drag=0.05; // avoidance dynamics
 int hull_colour=#888888;
 
Boat(){}   

 Boat(Fleet p,int i,PVector coords){   
        this.p=p;
	this.reg_no=i;	
	this.coords = coords;
	  
        setHeading(random(TWO_PI));	

   }

	  
void setHeading(float new_heading){
  while (new_heading>PI) 
			   new_heading=new_heading-TWO_PI;
		  
		  
		  while (new_heading<-PI) new_heading=new_heading+TWO_PI;
			
		  
		  heading = new_heading;
		  heading_vector= new PVector(sin(heading),cos(heading));

                  updateSailTrim();
}

void updateSailTrim(){
		 
  sail_angle=heading-PI-p.wind_direction;
		    if (sail_angle > PI) sail_angle-=TWO_PI;
		    if (sail_angle < -PI) sail_angle+=TWO_PI;
		    
		    sail_angle*=0.5;
		}

void move(){
		//if (Math.abs(sail_angle)>0.1)
		coords.add(PVector.mult(heading_vector,speed));
               
             
             if (coords.x>width/2) coords.x=-width/2+(coords.x+width/2)%width;
             if (coords.x<-width/2) coords.x=width/2+(coords.x+width/2)%width;
             if (coords.y>height/2) coords.y=-height/2+(coords.y+height/2)%height;
             if (coords.y<-height/2) coords.y=height/2+(coords.y+height/2)%height;
         
	}

void draw(){
 rectMode(CENTER);
 scale(0.3);
 strokeWeight(5);
		   
 // Draw the Hull
		   
  rotate(PI-heading);
  fill(hull_colour);
  noStroke();
  beginShape();
    vertex(-10,40);
    bezierVertex(-25,0,-5,-40,0,-50);
    bezierVertex(5,-40,25,0,10,40);
     
    endShape();
		   			   
    // Draw the Sail
    noFill();
    translate(0,-15);
    stroke(250);
    rotate(sail_angle);
    bezier(0,0,-sail_angle*12,15,-sail_angle*12,35,0,50);
		
    noStroke();
    fill(250,100,100);
    if (this.hasRightOfWay(p.boats[0])) ellipse(0,0,20,20);
		    
		
   strokeWeight(1);
	        


		  }     
   
   

Boat nearestBoat(){
    Boat nearest=new Boat(); // nearest boat index
	float d_nn=1e9; // nearest neighbour distance
	
	for (int j = 0; j <= p.density; j++) {
		
	  if (j!=this.reg_no){ 	
		 float d = this.coords.dist(p.boats[j].coords); 
		 if (d<d_nn)  {nearest=p.boats[j]; d_nn=d;  } 
	  }
	}

    return nearest;
}
   
  void turnRight(){ setHeading(heading-0.06);	}
	
  void turnLeft(){  setHeading(heading+0.06);	}
  
  void avoidCollisions(){
   
   Boat nearest=nearestBoat();
   if (isApproaching(nearest)&&nearest.coords.dist(this.coords)<1.2*sigma) lastMinute(nearest);
   else   {if (nearest.hasRightOfWay(this)) anticipate(nearest); else setHeading(heading+random(0.01));}
   
  }
    
   void lastMinute(Boat nearest){  // last ditch avoidance
    
   PVector s= PVector.sub(nearest.coords,this.coords);
      
	float  delta=s.x*cos(heading)-s.y*sin(heading);
	if (delta<0) turnLeft(); else turnRight();
  
     
   }
  
  void anticipate(Boat otherBoat){   // stately avoidance
	  
	float v,R_ij,dh;  
	
	R_ij= this.coords.dist(otherBoat.coords)/sigma/4;  
	if (R_ij>1)	v=1/pow(R_ij,6); else v=1;
	float force=v*sin(this.heading-otherBoat.heading);
	dh=min(0.3f,drag*force);
	dh=max(-0.3f,drag*force);
	setHeading(heading+dh);
     
     
  }
  
    boolean isApproaching(Boat otherBoat){
	
	   PVector s= PVector.sub(this.coords,otherBoat.coords);
       PVector dh=PVector.sub(this.heading_vector, otherBoat.heading_vector);
       if (s.dot(dh)<0) return true;
	   
	   return false;
   }
  
   boolean hasRightOfWay(Boat otherBoat){
	   
	   // check for Links Bringt's right of way
	    if (this.sail_angle>0&&otherBoat.sail_angle<0) return true;
	    if (this.sail_angle<0&&otherBoat.sail_angle>0) return false;
	   // check for leeward right of way
              PVector d= PVector.sub(this.coords,otherBoat.coords);
	    
	  if (d.dot(p.wind_direction_vector)>0) 	return true;						   
	   return false;
   }


}
 

 