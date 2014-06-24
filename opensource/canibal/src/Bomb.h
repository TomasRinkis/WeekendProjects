//
//  Bomb.h
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

#import <Foundation/Foundation.h>

@class CNBPlayer;
@class CNBSequence;

@interface Bomb : FlxSprite
{
  CGFloat myY;
  CNBPlayer * p;
  FlxEmitter * e;
  NSArray * en;
  CNBSequence * s;
}

+ (id) bombWithOrigin:(CGPoint)origin player:(CNBPlayer *)player gibs:(NSArray *)entry sequence:(CNBSequence *)sequence;
- (id) initWithOrigin:(CGPoint)origin player:(CNBPlayer *)player gibs:(NSArray *)entry sequence:(CNBSequence *)sequence;

- (void) add:(FlxEmitter *)gibs;

@end
