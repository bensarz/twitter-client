//
//  TweetProducerTests.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import XCTest
@testable import TwitterClient

class TweetProducerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTweetList() {
        let tweets = [
            "*answers phone*\n*nothing but heavy breathing on the other end*\nGRANDFATHER\nAT LAST",
            "*applies black eyeliner*\nmy parents don't understand me and i hate them\n*applies black helmet*",
            "*approaches you at party*\n*clears throat*\nhas anyone ever told you your eyes are the color of Darth Vader's helmet glinting in the moonlight",
            "*calligraphies DARTH VADER on the cover of all his notebooks in black magic marker*",
            "*comes downstairs in pajamas* \n*clears throat* there's been an awakening \nare there pancakes?",
            "*constructs a new lightsaber to cut the crusts off his sandwiches*",
            "*flexes bicep in his bathroom mirror* impressive... MOST impressive",
            "*force-opens the door for you when you're too far away so you have to run for it*\nyou're WELCOME!",
            "*force-slams his bedroom door*",
            "*gestures*\n*door opens*\nyes Rey you see when you are as powerful as I you can do these things\n\"kylo that was an automatic door\"",
            "*hands Rey a crossword*\ndon't worry if it takes a while \nWednesday puzzles can be a bit challengi--\n*Rey hands back the completed puzzle*",
            "*indignantly removes wookiee hair from his black outfit with a lint roller* dad i told you that couch was off limits to him",
            "*once used the force to hold the door open for a lady*\n*continues to use this as an example to prove sexism goes both ways*",
            "*picks out all the green and blue M&Ms and just eats the red ones*",
            "*places Darth Vader's burned-out helmet on piano*\n*painstakingly picks out the piano part to 'my immortal' with one finger*",
            "*reverently* that's so wizard",
            "*sets Vader breathing as his text message tone*",
            "*spends a whole afternoon unsuccessfully struggling to open a cling-wrapped My Chemical Romance cd*",
            "*stands apologetically beneath your window with a boombox playing the Imperial March*",
            "*writes \"search your feelings. you know it to be true\" on his Converse in black sharpie*",
            "a thing a lot of people don't realize about darth vader is what a way with words he had",
            "Are You There Darth? It's Me, Kylo",
            "chuck palahniuk just gets it",
            "current status: if there's a bright center to the universe \ni'm on the planet that it's farthest from",
            "current status: in a sarlacc pit \nbut emotionally",
            "dad can you please buy red milk next time instead of blue",
            "dad said i remind him of jabba's palace because i have a little rancor in me\nit felt like he'd planned it\nmom didn't think it was that funny",
            "dad the wookiee used all my garnier fructis",
            "Darth Vader had no father\nI envy him",
            "darth vader's haikus \ngot the syllable count right\nbut so far mine don't",
            "dear diary\nhux got me a poster of darth vader for my locker\ni already have one just like it but bigger\nhowever, i appreciated the thought",
            "dear diary\nI told hux I did not think much of his name for our band \nhe said I should go solo \nI told him never to mention that name again",
            "dear diary\nat lunch hux read me part of this manifesto he's been writing\nit really covered a lot of ground",
            "dear diary\nc3po told me the chances of survival on my route to school were 725 to 1 and i shouted at him to shut up\nam i becoming my father",
            "dear diary\nhux and i are meeting up by our lockers for an exchange of gifts\ni got him a moleskine to write speeches in\nhopefully he likes it",
            "dear diary\nhux and i are wearing black to commemorate the defeat at the battle of endor\nwe both always wear black but today it means more",
            "dear diary\nhux and i have made livejournal accounts\nhis name on it is starkiller and mine is xXxVaderxXx",
            "dear diary\nhux is lending me his copy of endor's game\nhe says he has never related to a protagonist so much\ni like it just okay",
            "dear diary\nhux let me borrow his copy of catcher in the rye\nit's okay so far",
            "dear diary\nhux wants me to come over and watch the films of leni riefenstahl\nbut it doesn't sound like darth vader is in them",
            "dear diary\ni am taking grandfather's helmet to school today to show to hux at lunch\ni expect he will be quite impressed",
            "dear diary\ni think my voice is changing\nbut it could be that i'm wearing a helmet with a voice changer now",
            "dear diary\ni told hux we should have a band of our own and he said yes but only if we call it Grand Moff Jerjerrod",
            "dear diary\nin solidarity with darth vader's creation i'm turning c3po back on when my parents shut him off\nthey have no right to silence him",
            "dear diary\nmom and dad still don't believe that my name is kylo\ndad laughs whenever i say it\nnobody at school calls me kylo but hux",
            "dear diary\nsome people are just shallow i guess",
            "dear diary\nthe stupid ewoks are visiting again\nit's torture\nwe have had to sing \"yub nub\" three times\nI never asked to be part of this tribe",
            "dear diary\nthe substitute math teacher kept calling me \"rilo kiley\"\nit was upsetting \nhux says he is an untermensch \nI guess we are talking",
            "dear diary\nthis one idiot ewok tripped and got a bucket stuck on his head\nuncle lando goes \"look, ben! it's you!\"\nhe is the literal worst",
            "dear diary\ntoday hux and I took a quiz to find our hogwarts houses\nhe got slytherin \nI got hufflepuff the first time but it was a mistake",
            "dear diary\ntoday i moved all of Hux's pens around to show him my tremendous powers \nbut Hux doesn't like it when people move his things",
            "dear diary\ntoday i spoke to a girl\ni called her m'lady and said I hate sand\nit worked for Darth Vader but i guess he knew something I don't",
            "dear diary\nwow\nc3po really loves to talk\ndarth vader must have felt it was important for him to tell people statistics but i dont know why",
            "diary i think this is for the best\ni was sick of watching 'triumph of the will' \nhux likes it way more than i do anyhow",
            "ewoks are traitors",
            "fight club is a great movie \nit gets to the truth of things",
            "fine I will go to the dance dad\nbut I will not dance \nI will wear a dark peacoat and stand in a corner with hux passing judgment on everyone",
            "fudge sand\nseriously",
            "FYI mom\n\"if you see our son, bring him home\" is way too dramatic of a way to ask dad to pick me up from band practice \njust in my opinion",
            "grandpa\ndoes my hair look okay",
            "holden caulfield knows what it means to commit to a bold choice of headgear and i respect that",
            "hux and I are building a new Death Star in place of the one that broke\nhux says if we don't it lets them win\nit will be the same but bigger",
            "hux is all right but he likes wagner too much",
            "hux says women are a distraction",
            "hux the important thing isn't what YOU think of these skinny jeans it's what Darth Vader would have thought of them",
            "i also mentioned that i would support a dictator and could see myself slaughtering sandpeople but by then she was quite far away",
            "i believe in absolutes",
            "i didn't crash the ship dad everything's fine\n*waves hand*\ni didn't crash the ship dad everything's fine\nwhy isn't this working",
            "i don't know why my family celebrates wookiee life day\nit's bullshit\nit's not even our heritage",
            "i don't really want to read atlas shrugged but hux says it's a must",
            "i get all my winter clothes at Hoth Topic",
            "i miss darth vader every day but i've never even met him",
            "i prefer dark craft beers",
            "i relate to holden caulfield",
            "i should warn you that am very strong in the force\n*tries to force-pull the cap off a pen*\n*can't*",
            "i suppose i was just born into the wrong era\nthat's all",
            "i think dad's walking carpet resents me for some reason",
            "i told hux what my dad said about Death Stars and he is coming over for moral support",
            "i told my dad he should let me get my license since I share DNA with the best starpilot in the galaxy\nhe was touched but I meant darth vader",
            "i was not crying in the shower \ni just realized how i'll never get to meet darth vader and then soap got in my eye",
            "i will NEVER go through mom's closet again for any reason\ni touched it before I knew what it was\nit was gold and metal\nI'm scarred forever",
            "i wish i'd suffered more",
            "i wish more words rhymed with darth vader  \nI guess not every poem needs to rhyme",
            "i'm not my father\nyou can tell me the odds\ni just can't even",
            "i'm wearing this black armband in honor of darth vader remembrance day\nit's every day",
            "if we don't resist the call of the light we're no better than moths",
            "is this bantha fodder locally sourced",
            "it's IN there\nand now you'll GIVE it to me\n*as he fights with a vending machine*",
            "just once i wish my dad would respond to \"I love you\" with \"I love you too\" \nmom too for that matter",
            "just to clarify: it is not a blankie \nit is an heirloom piece of darth vader's cape and i don't technically NEED it to fall asleep",
            "mom \nplease check your texts \ni had a fit of extreme power and rage where i mistakenly force-crushed my retainer",
            "mom please don't even pretend you know what I'm going through right now \nalso we are out of conditioner",
            "mom\ncan you come pick me up\nmy tauntaun died\nplease hurry it is quite cold",
            "my dad just knocked over my model Death Star and broke it\nbut he did not apologize\nhe said people should stop making Death Stars\nI'm shaking",
            "my dad owns too many vests",
            "my dad thinks he's so good at fixing things but he isn't really \nDarth Vader could fix anything",
            "my family should give C3PO more respect\nDarth Vader built him\nhe is darth vader's legacy",
            "my mom has done a lot of crazy things with her hair but i strive for more of a classic look myself",
            "my name is kyle\nmy name is kyle\nmy name is kyle\nmy name is KYLO\nfudging autocorrect",
            "my two favorite colors are black and red",
            "no i don't look \"strong enough to pull the ears off a gundark\" dad\nthat is gundark cruelty\nlanguage has power",
            "podracing is the realest sport \ni respect podracers so much",
            "Rey i see your ship is stuck in a swamp\nluckily for you i am quite powerful in the force \n*strains*\n*ship sinks deeper and disappears*",
            "should my yearbook quote be \"the ability to destroy a planet is insignificant next to the power of the Force\" or \"yippee\"",
            "sometimes i wish i weren't an only child\nbut mom says when you have siblings weird things can happen",
            "sorry Rey no bottle openers \nbut don't worry i know this great Force trick \n*concentrates fiercely*\n\"Kylo this one is a twist-off\"",
            "the dark side is the source of my unbelievable power\n*as he angrily fails to unwrap a processed cheese slice*",
            "the only person who could truly understand what i'm going through died on the second death star before i was even born",
            "there is no way that han shot first\nhan is a coward",
            "there's nothing sadder than a middle-aged man in a vest",
            "they make fun of me but kylo ren is a way realer name than biggs darklighter, the actual name of a man who my grandpa killed in a battle",
            "this elliot smith song really makes me think of darth vader",
            "ugh parsecs are units of distance DAD",
            "uncle lando said my helmet made me look like a depressed lampshade and then everyone laughed and high-fived him\ni hate this family so much",
            "what if men and women just have naturally different levels of force ability",
            "what's the word for when your father is frozen in carbonite but emotionally for your whole childhood",
            "when Darth Vader changed his name i bet they were jerks about it too \npeople are small like that",
            "who the fudge is renly",
            "why don't YOU build another generation of Jedi @VeryLonelyLuke",
            "wookiee life day is a bullshit holiday",
            "wow dad great insight \n*rolls eyes* \nmany Bothans died to bring us THAT information",
            "yeah well DARTH VADER never SHOT his PHONE to get out of a conversation with his son, DAD",
            "you can't truly appreciate the imperial march until you hear it on vinyl",
            "you don't need a lot of fake friends when you have real friends like darth vader",
            "you know \n*gestures expansively*\nI can take whatever I want\n*Rey sighs*\n\"kylo i know how buffets work\"",
            "you know who would have been a great host for SNL?\ndarth vader",
            "you're lucky I was here to help\nwith all my knowledge\n*confidently plugs your droid into a blast pocket instead of a computer terminal*",
            "~you are what you love, not who loves you~\n\ni'm darth vader",
        ]
        
        XCTAssertEqual(TweetProducer.tweets, tweets, "The list of tweets is invalid.")
    }
    
    func testPageSize() {
        let tweets = TweetProducer.tweetsSinceDate(NSDate(), pageSize: 1)
        XCTAssertEqual(tweets.count, 1, "The number of tweets is invalid. Expected: 1 | Actual: \(tweets.count)")
        let moarTweets = TweetProducer.tweetsSinceDate(NSDate(), pageSize: 1000)
        XCTAssertEqual(moarTweets.count, 1000, "The number of tweets is invalid. Expected: 1000 | Actual: \(tweets.count)")
        let evenMoarTweets = TweetProducer.tweetsSinceDate(NSDate())
        XCTAssertEqual(evenMoarTweets.count, 10, "The number of tweets is invalid. Expected: 10 | Actual: \(tweets.count)")
        let allTweets = TweetProducer.tweetsSinceDate(NSDate(), pageSize: TweetProducer.tweets.count)
        XCTAssertEqual(allTweets.count, 128, "The number of tweets is invalid. Expected: 127 | Actual: \(allTweets.count)")
    }
    
    func testTweetsContent() {
        let tweets = TweetProducer.tweetsSinceDate(NSDate(), pageSize: 1000)
        for tweet in tweets {
            XCTAssert(TweetProducer.tweets.contains(tweet.body), "The tweet body is not part of the TweetProducer.")
        }
    }
    
    func testTweetCreateDates() {
        let now = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let tweets = TweetProducer.tweetsSinceDate(now, pageSize: 1000)
        var tweetDate = calendar.dateByAddingUnit(.Minute, value: 10, toDate: now, options: .MatchNextTime) ?? now
        for tweet in tweets {
            XCTAssertEqual(tweet.createdDate, tweetDate, "The tweet's created date does not match the expected date.")
            tweetDate = calendar.dateByAddingUnit(.Minute, value: 10, toDate: tweetDate, options: .MatchNextTime) ?? tweetDate
        }
    }
    
}
