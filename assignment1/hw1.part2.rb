=begin
In a game of rock-paper-scissors, each player chooses to play Rock (R), Paper (P),
or Scissors (S). The rules are: Rock beats Scissors, Scissors beats Paper, but
Paper beats Rock.
A rock-paper-scissors game is encoded as a list, where the elements are 2-element
lists that encode a player’s name and a player’s strategy.
[ [ "Armando", "P" ], [ "Dave", "S" ] ]
# => returns the list ["Dave", "S"] wins since S>P

(a) Write a method rps_game_winner that takes a two-element list and behaves
as follows:
- If the number of players is not equal to 2, raise WrongNumberOfPlayersError
- If either player's strategy is something other than "R", "P" or "S" (case-insensitive),
raise NoSuchStrategyError
- Otherwise, return the name and strategy of the winning player. If both players use
the same strategy, the first player is the winner.
=end

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2    
    raise NoSuchStrategyError unless 
        game.all? { |p| ["R", "P", "S"].include?(p[1].upcase()) }
    
    p1 = game[0]
    s1 = p1[1].upcase()
    
    p2 = game[1]    
    s2 = p2[1].upcase()
    
    if s1 == s2 then return p1 end
    
    if s1 == "R" then
        if s2 == "S" then return p1 end
        if s2 == "P" then return p2 end;
    end
        
    if s1 == "P" then
        if s2 == "R" then return p1 end
        if s2 == "S" then return p2 end;
    end
    
    if s1 == "S" then
        if s2 == "P" then return p1 end
        if s2 == "R" then return p2 end;
    end    
end

puts "rps_game_winner tests"
p rps_game_winner([]) rescue puts "Wrong Number"
p rps_game_winner([ [ "Armando", "A" ], [ "Dave", "S" ] ]) rescue puts "No Such Strategy"
p rps_game_winner([ [ "Armando", "R" ], [ "Dave", "S" ] ])
p rps_game_winner([ [ "Armando", "P" ], [ "Dave", "S" ] ])
p rps_game_winner([ [ "Armando", "S" ], [ "Dave", "S" ] ])

p rps_game_winner([ [ "Armando", "R" ], [ "Dave", "R" ] ])
p rps_game_winner([ [ "Armando", "P" ], [ "Dave", "R" ] ])
p rps_game_winner([ [ "Armando", "S" ], [ "Dave", "R" ] ])

p rps_game_winner([ [ "Armando", "R" ], [ "Dave", "P" ] ])
p rps_game_winner([ [ "Armando", "P" ], [ "Dave", "P" ] ])
p rps_game_winner([ [ "Armando", "S" ], [ "Dave", "P" ] ])

=begin
(b) A rock, paper, scissors tournament is encoded as a bracketed array of games -
that is, each element can be considered its own tournament.
[
    [
        [ ["Armando", "P"], ["Dave", "S"] ],
        [ ["Richard", "R"], ["Michael", "S"] ],
    ],
    [
        [ ["Allen", "S"], ["Omer", "P"] ],
        [ ["David E.", "R"], ["Richard X.", "P"] ]
    ]
]
Under this scenario, Dave would beat Armando (S>P), Richard would beat Michael
(R>S), and then Dave and Richard would play (Richard wins since R>S); similarly,
Allen would beat Omer, David E. would beat Richard X., and Allen and Richard X.
would play (Allen wins since S>P); and finally Richard would beat Allen since R>P,
that is, continue until there is only a single winner. Write a method
rps_tournament_winner that takes a tournament encoded as a bracketed array
and returns the winner (for the above example, it should return [“Richard”,
“R”]). You can assume that the array is well formed (that is, there are 2^n players,
and each one participates in exactly one match per round).
=end

def rps_tournament_winner(array)
    
    def player?(x)
        return x.length == 2 && x[0].class.to_s == "String" && x[1].class.to_s == "String"
    end
    
    # Check is array a game or a player
    if player?(array) then return array end
    
    round1 = array[0]
    round2 = array[1]

    final = [ rps_tournament_winner(round1), rps_tournament_winner(round2)]
    
    return rps_game_winner(final)
end

puts "rps_tournament_winner tests"
p rps_tournament_winner(
[
    [
        [ ["Armando", "P"], ["Dave", "S"] ],
        [ ["Richard", "R"], ["Michael", "S"] ],
    ],
    [
        [ ["Allen", "S"], ["Omer", "P"] ],
        [ ["David E.", "R"], ["Richard X.", "P"] ]
    ]
])