/*
 * Copyright 2010-present Facebook.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#import "PNShareActionSheetHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface PNShareActionSheetHelper ()
@property (nonatomic, strong, readonly) UIViewController *topViewController;
@end



@implementation PNShareActionSheetHelper

- (UIViewController *)topViewController
{
  UIViewController *vc = UIApplication.sharedApplication.delegate.window.rootViewController;
  return vc;
}



- (void)copyLinkToClipboard
{
  UIPasteboard *pasteboard = UIPasteboard.generalPasteboard;
  pasteboard.persistent = YES;
  pasteboard.string = self.linkOfCurrentView;

  NSString *title = @"Link Copied to Clipboard";
  NSString *message = @"You can paste the link to other app to share this page now.";
  NSString *okButtonTitle = @"OK";

  UIAlertAction *action =
  [UIAlertAction actionWithTitle:okButtonTitle
                           style:(UIAlertActionStyleDefault)
                         handler:^(UIAlertAction * _Nonnull action)
  {
    //
  }];

  UIAlertController *ac =
  [UIAlertController alertControllerWithTitle:title
                                      message:message
                               preferredStyle:(UIAlertControllerStyleAlert)];

  [ac addAction:action];

  [self.topViewController presentViewController:ac animated:true completion:nil];
}


- (void)emailLink
{
  NSURLComponents *uc = [NSURLComponents componentsWithString:@"mailto:yourfriend@example.com"];
  uc.queryItems = @[
    [NSURLQueryItem queryItemWithName:@"subject" value:self.title],
    [NSURLQueryItem queryItemWithName:@"body" value:self.linkOfCurrentView],
  ];
  NSURL *emailtoURL = uc.URL;
  [UIApplication.sharedApplication openURL:emailtoURL];
}



- (void)launchActionList:(NSString *)title
{
  self.title = title;

  UIAlertAction *cancelAction =
  [UIAlertAction actionWithTitle:@"Cancel"
                           style:(UIAlertActionStyleCancel)
                         handler:^(UIAlertAction * _Nonnull action)
  {
    //
  }];

  UIAlertAction *copyAction =
  [UIAlertAction actionWithTitle:@"Copy Link to Clipboard"
                           style:(UIAlertActionStyleDefault)
                         handler:^(UIAlertAction * _Nonnull action)
  {
    [self copyLinkToClipboard];
  }];

  UIAlertAction *shareAction =
  [UIAlertAction actionWithTitle:@"Share Link via E-mail"
                           style:(UIAlertActionStyleDefault)
                         handler:^(UIAlertAction * _Nonnull action)
  {
    [self emailLink];
  }];

  UIAlertController *controller =
  [UIAlertController alertControllerWithTitle:title
                                      message:nil
                               preferredStyle:(UIAlertControllerStyleActionSheet)];
  [controller addAction:cancelAction];
  [controller addAction:copyAction];
  [controller addAction:shareAction];
  [self.topViewController presentViewController:controller animated:true completion:nil];
}

@end

NS_ASSUME_NONNULL_END
