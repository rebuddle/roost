# roost

## introduction
Roost? Strange name. Well if you think it has meaning you are wrong. But since it should have meaning I will put some meaning to it.

Roost is that early morning energy. It's the first thing you put your energy on in the morning. It's going to be my side project. 

I want to build video games so that I can bring entertainment to the world. My roost will either help me get there or I will fail miserably. Either way it's about the adventure. Right? 

See this as my devlog.

## cheat sheet
**Git commands**:
```
git add .
git push
git pull
git commit -m "<message>"
git branch -a
git branch <new-branch-name>
git branch -d <delete-branch-name>
git branch -m <old-branch-name> <new-branch-name>
git checkout <branch-name>
git checkout -b <new-created-branch-name>
git merge <branch-name>
```


## prototype phase
**04/22/2025** - I am currently in the prototype phase. I know I want to build out an action rpg (my main motivation is Archvale). However I want to make sure I master each concept along the way. 

Because of this I want to be able to successfully be able to build the following games:
1. Platformers
2. Top Down Shooters
3. Tower Defence

I beleive if I can successfully prototype these types of games, I can eventually work towards art/animation or get someone to help me to build a great final product. For now I just need to focus on game design and fun squares.

I have started a tutorial on a top down shooter. I think it would make sense to complete this and then build out a platformer and then a tower defence. I want to build all of the components before I move on to the next one.

Componenets:
1. Game Functionality
2. UI
3. Audio
4. Particles
5. Art/Animation
6. Story


I beleive that will be the order is the priority of enjoyment from video games.

## top-down shooter

### player movement
Okay so we need to deal with player movement. There seems to be alot of different ways to do this. Becuase we don't really need to have everything 100% optimized we have some flexibility. However there are two things that I want to avoid. 

1. Messy Code
2. Missed Frames


I want to make sure my code is very easy to digest and make changes to, while not missing any frames. Whenever I was looking at Finite State Machines in GameMaker there are different ways to implement them. For the most part there aren't too many differences, but one realization I had was how to use the start, run, and stop of the state.

GameMaker has a feature built in that you can run before step state, steps, then a portion that runs after the step. There are also other methods to handle starting/stopping like animations or timing, however, this is what I beleive can be leveraged to avoid skipping frames.

My initial solution implemented everything in the step phase which worked, but it would cost 1 frame for a stop and an additional frame for a start of any state. This required me to unravel the looping in the step phase making my code hard to digest.

To handle this the structure I will follow is below:

```
// finite state machine constructor
function state() constructor {
	start = function() {};
	step = function() {};
	stop = function() {};
}
```
