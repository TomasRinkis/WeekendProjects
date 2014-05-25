//
//  Shader.fsh
//  DriskelMator
//
//  Created by Brolis on 4/13/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

//http://glsl.heroku.com

precision mediump float;
varying vec4 vDestinationColor;
varying float fDestinationBackgroundType;

//<--------- Constants
const int c_circle_array_size = 4;

//<--------- Geometric elements
struct SCircle
{
    vec2 pos;
    float radius;
} m_CircleArray[c_circle_array_size];


//<-------  Utils
bool containsCircWithPoint(SCircle circ, vec2 pos)
{
    return length(circ.pos - pos) < circ.radius;
}

//<dingo mano meile dingo :(
vec4 mySuperNoise(vec2 pos)
{
    //return color
    return vec4(sin(pos.x * 20.0) + cos(pos.y * 20.0));
}

vec4 grid(vec2 pos)
{
    if(mod(pos.x, 0.1) < 0.005)
    {
        return vec4(1.0);
    }

    if(mod(pos.y, 0.1) < 0.005)
    {
        return vec4(1.0);
    }

    //returns color
    return vec4(0.0);
}



//<-------  Initilization
void initCornerCircles(void)
{
    m_CircleArray[0].pos    = vec2(-0.45, 0.6);
    m_CircleArray[0].radius = 0.1;
    
    m_CircleArray[1].pos    = vec2(0.45, 0.6);
    m_CircleArray[1].radius = 0.1;

    m_CircleArray[2].pos    = vec2(-0.45, -0.6);
    m_CircleArray[2].radius = 0.1;

    m_CircleArray[3].pos    = vec2(0.45, -0.6);
    m_CircleArray[3].radius = 0.1;
}


void main()
{
    
    initCornerCircles();
    
    vec2 resolution = vec2(768.0, 1024.0);
    vec2 origin = vec2(0.5);
    vec2 point = gl_FragCoord.xy/resolution - origin;
    vec4 color = vec4(0.0);
    vec4 inputColor = vDestinationColor;
    
    
    if(fDestinationBackgroundType >= 0.9)
    {
        color = vec4(length(point - origin));
    }
    else if(fDestinationBackgroundType >= 0.7)
    {
        for (int i = 0; i < c_circle_array_size; ++i)
        {
            color += 0.1/length(m_CircleArray[i].pos - point);
        }
    }
    else if(fDestinationBackgroundType >= 0.4)
    {
        color = mySuperNoise(point);
    }
    else if(fDestinationBackgroundType >= 0.2)
    {
        color = grid(point);
    }
    else if(fDestinationBackgroundType >= 0.0)
    {
        color = vec4(1.0);
    }
    
    gl_FragColor    =  color * inputColor;
    
}
