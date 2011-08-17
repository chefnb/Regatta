class Fleet {
    
  Boat[] boats;
  int density;    
   	 
  float wind_direction;
  PVector wind_direction_vector;



   Fleet(int density){ 
	
    this.density=density;
    wind_direction=0.2;
    wind_direction_vector=new PVector(sin(wind_direction),cos(wind_direction));

    boats = new Boat[density+1];
   
     
    for (int i = 1; i <= density; i++) {  
    boats[i]= new Boat(this,i,new PVector(random(-width/2,width/2),random(-height/2, height/2)));
    }	   

  // the avatar
   boats[0]=new Boat(this,0,new PVector(0,0));
   boats[0].speed=0;
   boats[0].hull_colour=#113311;
   boats[0].setHeading(PI);
   
   }
	
  void update(float wind){
    
      wind_direction=wind;
      wind_direction_vector.x=sin(wind_direction);
      wind_direction_vector.y=cos(wind_direction);
	    
   for (int i = 1; i <= density; i++) {  
      boats[i].updateSailTrim();
       
      if (running) {
          boats[i].avoidCollisions();
          boats[i].move();	
      }
     }

   boats[0].updateSailTrim();
     
     
  }
	 
   void draw(){   
      pushMatrix();
      translate(width/2,height/2);
      for (int i = 0; i <= density; i++) {  
	  pushMatrix();
	  translate(boats[i].coords.x,boats[i].coords.y);
	  boats[i].draw();
	  popMatrix();
      }
     popMatrix();   
   }
	    	

}



