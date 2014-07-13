//
//  Shader.vsh
//  DriskelMator
//
//  Created by Brolis on 4/13/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

uniform mat4 projectionMatrix;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;

attribute vec4 vPosition;
attribute vec4 vColor;

varying vec4 vDestinationColor;

void main(void)
{
    gl_Position         = projectionMatrix * modelMatrix * viewMatrix * vPosition;
    vDestinationColor   = vColor;
}