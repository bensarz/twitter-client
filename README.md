# TwitterClient

## Overview

This repository contains a simple TwitterClient application. Unfortunately, it does not use the actual Twitter API.
Instead it mimic the API using a `TweetProducer` class.

It is a coding exercise for Trov to review.

## Environment

It is assumed that you have Ruby 2.0.0 installed or later and that you have the `bundler` gem installed.
If you do not have the `bundler` gem installed, please run the following at the command line (you may have to use `sudo` if you're using the system version of Ruby):

```
$ gem install bundler
```

Now, you can clone the repository on your desktop:

```
$ git clone https://github.com/bensarz/twitter-client
Cloning into 'twitter-client'...
remote: Counting objects: 200, done.
remote: Compressing objects: 100% (146/146), done.
remote: Total 200 (delta 95), reused 141 (delta 40), pack-reused 0
Receiving objects: 100% (200/200), 112.66 KiB | 0 bytes/s, done.
Resolving deltas: 100% (95/95), done.
Checking connectivity... done.
```

This project uses `Rake` to simply certain tasks. A few more gems are necessary to automate this setup.
After you have cloned the repository, run the following commands (you may be asked for your password if you're using the system version of Ruby):

```
$ cd twitter-client
$ bundle install
Using rake 10.5.0
Using i18n 0.7.0
Using json 1.8.3
.....
Using fastlane 1.53.0
Bundle complete! 7 Gemfile dependencies, 91 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

## Building & Testing

The following commands assumes you have Xcode 7.2 (7C68) installed and you have a simulator named "iPhone 6S Plus". Otherwise, the tests might not run successfully.

Then it's just a matter of using `Rake` to your advantages:

```
$ rake
Removing the 'Gemfile.lock' file.
rm -rf Gemfile.lock
Running 'bundle install'
bundle install
Fetching gem metadata from https://rubygems.org/..........
Fetching version metadata from https://rubygems.org/...
Fetching dependency metadata from https://rubygems.org/..
Resolving dependencies....
Rubygems 2.0.14 is not threadsafe, so your gems will be installed one at a time. Upgrade to Rubygems 2.1.0 or higher to enable parallel gem installation.
Using rake 10.5.0
Using i18n 0.7.0
Using json 1.8.3
.....
Using fastlane 1.53.0
Bundle complete! 7 Gemfile dependencies, 91 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
Removing the 'Pods/' folder.
rm -rf Pods
Removing the 'Podfile.lock' file.
rm -rf Podfile.lock
Running 'pod install'
pod install
Updating local specs repositories

CocoaPods 1.0.0.beta.2 is available.
To update use: `gem install cocoapods --pre`
#[!] This is a test version we'd love you to try.

For more information see http://blog.cocoapods.org
and the CHANGELOG for this version http://git.io/BaH8pQ.

Analyzing dependencies
Downloading dependencies
Installing Log (0.1)
Installing Realm (0.97.0)
Installing RealmSwift (0.97.0)
Installing SVProgressHUD (1.1.3)
Generating Pods project
Integrating client project
Sending stats
Pod installation complete! There are 3 dependencies from the Podfile and 4 total pods installed.
```

You can now run the tests using the following command:

```
$ rake test
Compiling the Xcode project
xcodebuild -workspace TwitterClient.xcworkspace -scheme TwitterClient -sdk iphonesimulator9.2 -destination 'platform=iOS Simulator,name=iPhone 6S Plus'  -configuration Debug clean test | xcpretty -r html
▸ Cleaning .....
▸ Check Dependencies .....
▸ Building .....
▸ Copying .....
▸ Processing .....
▸ Compiling .....
▸ Linking .....
▸ Generating .....
▸ Touching .....
.....
▸ Test Succeeded
All tests
Test Suite TwitterClientTests.xctest started
DateFormatsTests
    ✓ testConstants (0.001 seconds)
NSDateExtensionsTests
    ✓ testDefaultStringValue (0.000 seconds)
    ✓ testISO8601StringValue (0.001 seconds)
    ✓ testSimpleStringValue (0.001 seconds)
NSDateFormatterExtensionsTests
    ✓ testDefaultDateFormatter (0.001 seconds)
    ✓ testISO8601DateFormatter (0.001 seconds)
    ✓ testSimpleDateFormatter (0.001 seconds)
StringExtensionsTests
    ✓ testDefaultDateValue (0.002 seconds)
    ✓ testISO8601DateValue (0.001 seconds)
    ✓ testSimpleDateValue (0.001 seconds)
TweetProducerTests
    ✓ testPageSize (0.008 seconds)
    ✓ testTweetCreateDates (0.010 seconds)
    ✓ testTweetList (0.001 seconds)
    ✓ testTweetsContent (0.025 seconds)
TweetTests
    ✓ testDefaultValues (0.001 seconds)
    ✓ testInitDictionary (0.002 seconds)
    ✓ testParsingKeys (0.001 seconds)
    ✓ testRealm (0.000 seconds)
UserTests
    ✓ testDefaultValues (0.000 seconds)
    ✓ testInitDictionary (0.001 seconds)
    ✓ testInitPasswordUsername (0.000 seconds)
    ✓ testParsingKeys (0.000 seconds)
    ✓ testRealm (0.000 seconds)


     Executed 23 tests, with 0 failures (0 unexpected) in 0.057 (0.073) seconds

All tests
Test Suite TwitterClientUITests.xctest started
TwitterClientUITests
    ✓ testExample (3.120 seconds)


     Executed 1 test, with 0 failures (0 unexpected) in 3.120 (3.121) seconds

An HTML report has been created for you in './build/reports/tests.html'
```

