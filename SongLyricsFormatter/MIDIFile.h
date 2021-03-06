//
//  MIDIFile.h
//  MIDIVis
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

extern NSString *const MIDINoteTimestampKey;
extern NSString *const MIDINoteDurationKey;
extern NSString *const MIDINotePitchKey;
extern NSString *const MIDINoteTrackIndexKey;

@interface MIDIFile : NSObject {
  @private
	MusicPlayer player;
	MusicSequence sequence;
	MusicTimeStamp sequenceLength;
	NSTimer *checkTimer;
}

@property (nonatomic, readonly) BOOL isPlaying;

+ (id)fileWithPath:(NSString *)path;
- (id)initWithPath:(NSString *)path;

- (MusicTimeStamp)beatsForSeconds:(Float64)seconds;
- (NSArray *)notes;

- (BOOL)play;
- (BOOL)stop;

@end
