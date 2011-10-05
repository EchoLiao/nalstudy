// hdrball.fs
//
// Based on toy ball shader by Bill Licea-Kane
// with HDR additions from Benj Lipchak

varying vec3 V; // object-space position
varying vec3 N; // eye-space normal
varying vec3 L; // eye-space light vector

uniform float bloomLimit;    // minimum brightness for bloom
uniform float starIntensity; // how bright is the star?

const vec3 myRed = vec3(1.1, 0.2, 0.2);
const vec3 myYellow = vec3(0.6, 0.5, 0.0);
const vec3 myBlue = vec3(0.0, 0.3, 0.6);

const vec3 myHalfSpace0 = vec3(0.31, 0.95, 0.0);
const vec3 myHalfSpace1 = vec3(-0.81, 0.59, 0.0);
const vec3 myHalfSpace2 = vec3(-0.81, -0.59, 0.0);
const vec3 myHalfSpace3 = vec3(0.31, -0.95, 0.0);
const vec3 myHalfSpace4 = vec3(1.0, 0.0, 0.0);

const float stripeThickness = 0.4;  // 0 to 1
const float starSize = 0.2;         // 0 to ~0.3
const float smoothEdgeTol = 0.005;
const float ambientLighting = 0.2;
const float specularExp = 60.0;
const float specularIntensity = 0.5;

void main (void)
{
    vec4 distVector;
    float distScalar;

    // Normalize vectors
    vec3 NN = normalize(N);
    vec3 NL = normalize(L);
    vec3 NH = normalize(NL + vec3(0.0, 0.0, 1.0));
    vec3 NV = normalize(V);

    // Each flat edge of the star defines a half-space.  The interior
    // of the star is any point within at least 4 out of 5 of them.
    // Start with -3 so that it takes adding 4 ins to equal 1.
    float myInOut = -3.0;

    // We need to perform 5 dot products, one for each edge of 
    // the star.  Perform first 4 in vector, 5th in scalar.
    distVector.x = dot(NV, myHalfSpace0);
    distVector.y = dot(NV, myHalfSpace1);
    distVector.z = dot(NV, myHalfSpace2);
    distVector.w = dot(NV, myHalfSpace3);
    distScalar = dot(NV, myHalfSpace4);

    // The half-space planes all intersect the origin.  We must
    // offset them in order to give the star some size.
    distVector += starSize;
    distScalar += starSize;

    distVector = smoothstep(0.0, smoothEdgeTol, distVector);
    distScalar = smoothstep(0.0, smoothEdgeTol, distScalar);
    myInOut += dot(distVector, vec4(1.0));
    myInOut += distScalar;
    myInOut = clamp(myInOut, 0.0, 1.0);

    // calculate diffuse lighting + 20% ambient
    vec3 diffuse = (ambientLighting + vec3(max(0.0, dot(NN, NL))));

    // colors
    vec3 yellow = myYellow * diffuse;
    vec3 blue = myBlue * diffuse;
    vec3 red = myRed * starIntensity;

    // red star on yellow background
    vec3 surfColor = mix(yellow, red, myInOut);

    // blue stripe down middle
    myInOut = smoothstep(0.0, smoothEdgeTol, 
                         abs(NV.z) - stripeThickness);
    surfColor = mix(blue, surfColor, myInOut);

    // calculate specular lighting w/ 50% intensity
    surfColor += (specularIntensity * 
        vec3(pow(max(0.0, dot(NN, NH)), specularExp)));

    gl_FragData[0] = vec4(surfColor, 1.0);

    // bright pass: only output colors with some component >= bloomLimit
    vec3 brightColor = max(surfColor - vec3(bloomLimit), vec3(0.0));
    float bright = dot(brightColor, vec3(1.0));
    bright = smoothstep(0.0, 0.5, bright);
    gl_FragData[1] = vec4(mix(vec3(0.0), surfColor, bright), 1.0);
}
