//
//  Hall.h
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

@class CBlock;

@interface Hall : FlxObject
{
  FlxTileblock * leftEdge;
  FlxTileblock * rightEdge;
  NSMutableArray * windows;
  NSMutableArray * walls;
  NSMutableArray * doors;
  CBlock * hall1;
  CBlock * hall2;
  FlxSprite * hall3;
  NSMutableArray * extraWindows;
  NSMutableArray * extraWalls;
  NSMutableArray * extraDoors;  
}
- (id) initWithMaxWidth:(float)maxWidth;
- (void) createWithX:(float)X y:(float)Y width:(float)Width height:(float)Height
	    tileSize:(float)tileSize
	  hallHeight:(float)hallHeight
	    wallType:(int)wallType windowType:(int)windowType;
@end
