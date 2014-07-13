//
//  Shader.fsh
//  DriskelMator
//
//  Created by Brolis on 4/13/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

precision mediump float;
varying vec4 vDestinationColor;

void main()
{
    gl_FragColor    =  vDestinationColor;
    
}
