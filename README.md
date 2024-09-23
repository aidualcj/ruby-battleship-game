# Ruby Battleship Game

Welcome to the Ruby Battleship Game! This is a terminal-based implementation of the classic Battleship game, where two players take turns guessing the location of each other's ships on a 5x5 grid. The first player to sink all of the opponent's ships wins the game.

<h2>Features</h2>

<ul>
  <li><strong>Interactive Gameplay</strong>: Play against another player in a turn-based mode.</li>
  <li><strong>Best of 3 Match Mode</strong>: The game supports a "Best of 3" match mode where the first player to win two games wins the match.</li>
  <li><strong>Customizable Ship Placement</strong>: Players can place ships of different sizes and orientations on the grid.</li>
  <li><strong>User-Friendly Interface</strong>: Simple terminal interface with clear instructions and feedback.</li>
</ul>

<h2>Getting Started</h2>

<h3>Prerequisites</h3>

<p>Make sure you have Ruby installed on your computer. You can download Ruby from the <a href="https://www.ruby-lang.org/en/documentation/installation/">official website</a>.</p>

<h3>Installation</h3>

<ol>
  <li><strong>Ensure You Have Access</strong>: Make sure you have been added as a collaborator to the private repository.</li>
  <li><strong>Set Up SSH Access</strong>: If you haven't already set up SSH access to GitHub, follow the <a href="https://docs.github.com/en/authentication/connecting-to-github-with-ssh">GitHub SSH guide</a> to generate a new SSH key and add it to your GitHub account.</li>
  <li><strong>Clone the Repository</strong>: Once you have SSH access configured, open your terminal and run the following command to clone the game repository:</li>
</ol>

```bash
git clone git@github.com:aidualcj/ruby-battleship-game.git
```
<ol start="4">
  <li><strong>Navigate to the Project Directory</strong>: Change into the project directory:</li>
</ol>

```bash
cd ruby-battleship-game
```
<h3>Running the Game</h3> <p>To start the game, run the <code>main.rb</code> file in your terminal:</p>

```bash
ruby main.rb
```

<p>Follow the on-screen instructions to place your ships and start the game. Enjoy battling it out with your opponent!</p> <h3>How to Test the Project</h3> <p>To run the tests, make sure you have RSpec installed. If you haven't installed RSpec yet, you can do so by running:</p>

```bash
gem install rspec
```

<p>Then, run the tests with:</p>

```bash
rspec --format documentation
```

<p>This command will run all the test suites and display the test results in a readable format.</p> <h3>What the Tests Cover</h3> <ul> <li><strong>Game Mechanics</strong>: Ensure that ship placement, shooting, and game turns work correctly.</li> <li><strong>Best of 3 Mode</strong>: Tests for verifying the match-winning logic when a player wins two out of three games.</li> <li><strong>User Input Handling</strong>: Tests to validate that user inputs are processed correctly and do not cause unexpected behavior.</li> </ul> <h3>Development Approach</h3> <p>This project was developed step-by-step as outlined in the assignment requirements. Each step was fully completed before moving on to the next, ensuring a structured and well-tested game development process.</p> <h4>Step-by-Step Breakdown</h4> <ol> <li><strong>Step 1 - Board Setup</strong>: Created a 5x5 grid for each player and implemented ship placement mechanics.</li> <li><strong>Step 2 - Gameplay Setup</strong>: Developed the core gameplay loop where players take turns shooting at each other's boards.</li> <li><strong>Step 3 - Gameplay Improvements</strong>: Enhanced the gameplay with additional rules, random starting players, and a replay option.</li> <li><strong>Step 4 - Bonus Features</strong>: Added diagonal ship placements, hints after 3 consecutive misses, and a "Best of 3" match mode.</li> </ol>
