class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    @try = 7
    word.each_char {|letter| @word_with_guesses += '-'}
  end
  
  def guess(letter)
    if letter.nil? or not letter.match('[a-zA-Z]+') then raise ArgumentError end
    letter.downcase!
    if word.include? letter then
      if not @guesses.include? letter then 
        @guesses += letter
        update_word_with_guesses(letter)
      else 
        return false 
      end
    else
      if not @wrong_guesses.include? letter then 
        @wrong_guesses += letter
        @try -= 1
      else
        return false
      end
    end
    true
  end
  
  def update_word_with_guesses(letter)
    @word.each_char.with_index do |val, index|
      if val == letter then @word_with_guesses[index] = letter end
    end 
  end
  
  def check_win_or_lose
    if @try == 0 then
      return :lose
    elsif word_with_guesses.include? '-' then
      return :play
    else
      return :win
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
