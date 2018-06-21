#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	ofEnableDepthTest();
	ofEnableSmoothing();

	light.enable();
	light.setPosition(500, 0, 0);

	mesh = ofSpherePrimitive(200, 40).getMesh();
	shader.load("shader/shader.vert", "shader/shader.frag", "shader/shader.geom");
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
	ofEnableDepthTest();

	//Set a background
	ofBackgroundGradient(ofColor(255), ofColor(128));

	cam.begin();

	ofPushMatrix();

	// model Matrix
	ofMatrix4x4 modelMatrix;
	modelMatrix.translate(0, 0, 0);

	// view Matrix
	ofMatrix4x4 viewMatrix;
	viewMatrix = ofGetCurrentViewMatrix();

	// projection Matrix
	ofMatrix4x4 projectionMatrix;
	projectionMatrix = cam.getProjectionMatrix();

	// mvp Matrix
	ofMatrix4x4 mvpMatrix;
	mvpMatrix = modelMatrix * viewMatrix * projectionMatrix;

	shader.begin();
	shader.setUniform1f("time", ofGetElapsedTimef());
	shader.setUniformMatrix4f("projection", projectionMatrix);
	shader.setUniformMatrix4f("view", viewMatrix);
	shader.setUniformMatrix4f("model", modelMatrix);
	shader.setUniformMatrix4f("modelViewProjectionMatrix", mvpMatrix);
	shader.setUniformMatrix4f("cameraMatrix", cam.getModelViewMatrix());

	ofVec3f lightPos = light.getPosition();
	shader.setUniform3f("lightPos", lightPos.x, lightPos.y, lightPos.z);

	//Draw mesh
	mesh.draw();
	//mesh.draw(OF_MESH_WIREFRAME);

	shader.end();

	ofPopMatrix();

	cam.end();

	ofDisableDepthTest();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
