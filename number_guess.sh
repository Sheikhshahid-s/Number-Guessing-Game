#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  $PSQL "INSERT INTO users(username) VALUES('$USERNAME')" > /dev/null
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
  
else
  USER_STATS=$($PSQL "SELECT COUNT(game_id), MIN(guesses) FROM games WHERE user_id='$USER_ID'")

  IFS="|" read GAMES_PLAYED BEST_GAME <<< "$USER_STATS"

  if [[ -z $BEST_GAME ]]
  then
    BEST_GAME=0
  fi
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

SECRET_NUMBER=$((1 + RANDOM % 1000))

echo "Guess the secret number between 1 and 1000:"

GUESS_COUNT=0

while true
do
  read NUMBER_GUESSED

  if [[ ! $NUMBER_GUESSED =~ ^-?[0-9]+$ ]]
then
  echo "That is not an integer, guess again:"
else
  ((GUESS_COUNT++))
  
   if [[ $NUMBER_GUESSED -eq $SECRET_NUMBER ]]
   then
     echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
     break
   elif [[ $NUMBER_GUESSED -gt $SECRET_NUMBER ]]
   then 
     echo "It's lower than that, guess again:"
   elif [[ $NUMBER_GUESSED -lt $SECRET_NUMBER ]]
   then
     echo "It's higher than that, guess again:"
    fi
  fi
done

$PSQL "INSERT INTO games(user_id, guesses) VALUES('$USER_ID', '$GUESS_COUNT')" > /dev/null



