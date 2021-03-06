//
//  CNBSequence.h
//  CNBCanabaltGame
//
//  Copyright Semi Secret Software 2009-2010. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


@class CNBSequence;
@class CNBPlayer;
//@class RenderTexture;

@class Crane;
@class CNBBuilding;
@class Hall;
@class Billboard;
@class GibEmitter;
@class DoveGroup;

@interface CNBSequence : FlxObject
{
  //NSMutableArray * mBlocks;
  FlxGroup * blocks;
  BOOL roof;
  int type;
  BOOL passed; //helps with the epitaph type tracking
  FlxGroup * foregroundLayer;
  FlxGroup * layer;
  FlxGroup * renderLayer;
  FlxGroup * backgroundRenderLayer;
  FlxGroup * layerLeg;
  CNBSequence * seq;
  CNBPlayer * player;
//   NSArray * shardsA;
//   NSArray * shardsB;
  FlxEmitter * shardsA;
  FlxEmitter * shardsB;
  
//   RenderTexture * backgroundRenderTexture;
//   RenderTexture * renderTexture;
  
  NSArray * walls;
  NSArray * roofs;
  NSArray * floors;
  NSArray * windows;
  NSArray * antennas;

  CNBBuilding * building;
  
  FlxTileblock * escape;
  FlxTileblock * fence;

  DoveGroup * doveGroup;
}

+ (id) sequenceWithPlayer:(CNBPlayer *)player shardsA:(FlxEmitter *)shardsA shardsB:(FlxEmitter *)shardsB;
- (id) initWithPlayer:(CNBPlayer *)player shardsA:(FlxEmitter *)shardsA shardsB:(FlxEmitter *)shardsB;

+ (void) setNextIndex:(int)ni;
+ (void) setNextType:(int)nt;
+ (void) setCurIndex:(int)ci;
+ (int) nextIndex;
+ (int) nextType;
+ (int) curIndex;

//These are just for helping with the epitaphs
+ (void) setLastType:(int)lt;
+ (void) setThisType:(int)tt;
- (int) lastType;
- (int) thisType;

- (int) getType;
- (void) reset;
- (void) clear;
- (void) aftermath;
- (void) stomp;

- (void) initSequence:(CNBSequence *)sequence;

//@property (readonly) NSArray * blocks;
@property (readonly) FlxGroup * blocks;

@end

