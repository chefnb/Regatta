class WaveCrests {
    
  WaveCrest[] wavecrests;
  float speed=0.4;
  int density;    

  CapillarySurface watersurface;
   	 
   WaveCrests(int density){ 
	
    this.density=density;
    watersurface=new CapillarySurface(10,0.9,360,10);
    wavecrests = new WaveCrest[density];
    
    
    for (int i = 0; i <= density-1; i++) {  
    wavecrests[i]= new WaveCrest(new PVector(random(-width/2,width/2),random(-height/2, height/2)));
    }	       
   }
	



  void update(){
      
    if (running){ 
     
       for (int i = 0; i <= density-1; i++) {  
       wavecrests[i].move();
     }
    }  
  }   
  
	 
   void draw(){   
      pushMatrix();
      translate(width/2,height/2);
      for (int i = 0; i <= density-1; i++) {  
	  pushMatrix();
	  translate(wavecrests[i].coords.x,wavecrests[i].coords.y);
	  wavecrests[i].draw();
	  popMatrix();
      }
     popMatrix();   
   }
	    	


  class WaveCrest {
		
   PVector coords;
      
		WaveCrest(PVector coords){   
		this.coords=coords;	
		
		}

void move(){
 coords.y=coords.y+speed;
 if (coords.y>height/2) {
     coords.y=-height/2;
     coords.x=random(-width/2,width/2);
 }
}
		 	     
		void draw(){
			
		 noFill(); 
                 stroke(0,100,200);
                 strokeWeight(1);
                 scale(0.5);
		

                 float d=watersurface.displacement(coords.x,coords.y);
			

                 bezier(-10-d/15,10,
		    -5,10+d/15, 0,10-d/7,
		   15+d/6.0,10);
		   
		
		   
		} 
		
		
  }
		  




		
// A surface built from Fourier components  
	
class CapillarySurface {
      ArrayList waves;
	
	  CapillarySurface(int n,float kseed,float dirseed,float ampseed){
	  
	    waves = new ArrayList();
	   generateRandom(n,kseed,dirseed,ampseed);
	  }
	  
		  


	  void generateRandom(int n,float kseed,float dirseed,float ampseed){
	 
	   float k;
           float dir;
           float amp;  
	    
	  for (int i = 0; i < n; i++) {  
	   
	    k=random(kseed);dir=random(dirseed);amp=random(ampseed); 
	    createWave(k,dir,amp);   
	    }
	 }
	 
	   
	 
	void createWave(float k, float dir, float amp){ 
		
		waves.add(new Wave(k,dir,amp));
	}
	  
	float displacement(float x,float y){
	  
	    float displacement=0;
	    for (int i = waves.size()-1; i >= 0; i--) {
	        Wave wave = (Wave) waves.get(i);
	        displacement+= wave.amplitude*cos(x*wave.k_x+y*wave.k_y);
	     }    
	    return displacement;
	}


	
	class Wave {

	  float k; 
	  float direction;
	  float amplitude;
	  float k_x;
	  float k_y;
	  
	 Wave(float k, float dir, float amp){
	   this.k=k;
	   this.direction=dir;
	   this.amplitude=amp;
	 
	   k_x=k*sin(TWO_PI*direction/360);
	   k_y=k*cos(TWO_PI*direction/360);
	}

	}   
	 
	}
	 
}


