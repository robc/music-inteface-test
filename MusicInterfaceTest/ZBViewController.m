//
//  ZBViewController.m
//  MusicInterfaceTest
//
//  Created by Rob Caporetto on 13/02/13.
//  Copyright (c) 2013 zerobytes. All rights reserved.
//

#import "ZBViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ZBViewController ()
@end

@implementation ZBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MPMusicPlayerController *musicController = [MPMusicPlayerController iPodMusicPlayer];
    [musicController beginGeneratingPlaybackNotifications];
    [self updateStatusTextWithPlaybackState:[musicController playbackState]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateDidChange:)
                                                 name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)playbackStateDidChange:(NSNotification *)notification
{
    [self updateStatusTextWithPlaybackState:[[MPMusicPlayerController iPodMusicPlayer] playbackState]];
}

- (void)updateStatusTextWithPlaybackState:(MPMusicPlaybackState)playbackState
{
    // This is phase one. We need phase two where we can do the same for non-system apps.
    // That is of course, unless the behaviour has changed in iOS 4+, where the background support
    // allows for it.
    
    self.textView.text = (playbackState == MPMusicPlaybackStatePaused || playbackState == MPMusicPlaybackStateStopped ? @"Can Play App Music" : @"Cannot Play App Music.");
}

@end
