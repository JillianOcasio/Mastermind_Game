class Game
    CODE_PEGS=["r","o","y","b","g","p"]

    attr_reader :name, :computer, :correct_color, :correct_guess, :game_counter, :code_guess, :code_hidden
    def initialize(input)
        @name = "Player"
        @computer="Computer"
        @game_counter=12
        @code_guess=code_guess
        @code_hidden=code_hidden
        @correct_color=correct_color
        @correct_guess=correct_guess
    end

              
    def computer_codemaker()
        return CODE_PEGS.sample(4)
    end  

    def isCorrect(i)
        if @code_guess[i]==@code_hidden[i]
            return true 
        else 
            return false 
        end 
    end 

    def colorCorrect(i)
        j=0
        while j<5
            if @code_guess[i]==@code_hidden[j]
                return true  
            else
                j+=1
            end   
        end
        return false 
    end  

        def compare_guess()
            i=0
            @correct_guess=0
            @correct_color=0
            while i<4
                if isCorrect(i) && colorCorrect(i)
                    @correct_guess+=1
                    @correct_color+=1 
                    i+=1
                elsif isCorrect(i)
                    @correct_guess+=1
                    i+=1
                elsif colorCorrect(i)
                    @correct_color+=1 
                    i+=1
                else  
                    i+=1
                end
            end 
        end
 
    def fix_code(code_submit)
        code_adjust=code_submit.chars
        if code_adjust.length==4
            return code_adjust
        else 
            return ""
        end 
    end 
        
        def round_of_play()
            puts ask_player
            selection_player = gets.chomp
            if selection_player=="1"
                puts "Please make your code below"
                code_submit = gets.chomp
                @code_hidden=fix_code(code_submit)
                game_codemaker()
            elsif selection_player=="2" 
                puts player_question
                @code_hidden = computer_codemaker()
                game_guesser()
            end 
        end 

        def game_guesser()
            while @game_counter>0
                code_submit=gets.chomp.downcase
                @code_guess=fix_code(code_submit)
                compare_guess()
                @game_counter-=1
                if win?
                    return puts "You Cracked the Code!"
                elsif @game_counter>0 
                    puts "You have : #{@correct_color} correct colors  & #{@correct_guess} correct guesses. Try again!"
                elsif @game_counter==0 
                    puts "Try again! You didn't crack the code!"
                end
            end
        end 

        def game_codemaker()
            @code_guess=computer_codemaker()
            while @game_counter>0
                @correct_guess=0
                @correct_color=0
                compare_guess()
                puts "This is a guess #{@code_guess} for game #{@game_counter}"
                @code_guess=code_assessement()
                puts "This is the new guess: #{@code_guess} for game #{@game_counter}"
                @game_counter-=1  
                if win?
                    return puts "The Computer cracked the Code! Would you like to play again" 
                end
            end
            puts "Wow you beat the computer good job!"   
        end 
           
        def code_assessement()
            @code_guess.shuffle!
            if @correct_color==4
                return @code_guess
            elsif @correct_color==3 || @correct_color==1
                color_not_included=CODE_PEGS-@code_guess
                random_color=color_not_included.sample()
                @code_guess=@code_guess.push(random_color)
                @code_guess.slice!(0)
                @code_guess.flatten!
                return @code_guess
            elsif @correct_color==2
                color_not_included=CODE_PEGS-@code_guess
                @code_guess=@code_guess.push(color_not_included)
                @code_guess.slice!(0)
                @code_guess.slice!(0)
                @code_guess.flatten!
                return @code_guess
            else 
                return "you have a problem"
            end 
        end 
            

        def win?
            @correct_guess==4
        end

        def player_question()
            "The computer created a 4 digit code from the colors: red, orange, yellow, blue, green, and purple using:#{CODE_PEGS} using the abbreviations.  You have #{@game_counter} guesses!  Can you guess the code?"
        end 
        def ask_player
            "Welcome to Mastermind! The game where Do you want to be the CodeMaker(1) or CodeBreaker(2)??"
        end
    end
game = Game.new("Player")
game.round_of_play()