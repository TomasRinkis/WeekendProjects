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
attribute float fBackgroundType;

varying vec4 vDestinationColor;
varying float fDestinationBackgroundType;

void main(void)
{
    gl_Position                 = projectionMatrix * modelMatrix * viewMatrix * vPosition;
    vDestinationColor           = vColor;
    fDestinationBackgroundType  = fBackgroundType;
}