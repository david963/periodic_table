#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ELEMENT=$1
# if doesn't contain argument
if [[ -z $ELEMENT ]]
then
  echo Please provide an element as an argument.
else
  # if argument is not an element
  if [[ $ELEMENT = 1 ]]
  then
    echo "I could not find that element in the database."
  else
  ELEMENTS=$($PSQL "SELECT * FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number)")

  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $ELEMENT")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = $ELEMENT")
  NAME=$($PSQL "SELECT name FROM elements WHERE name = $ELEMENT")

  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ELEMENT")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE name = $ELEMENT")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsisu FROM properties WHERE name = $ELEMENT")
  TYPE=$($PSQL "SELECT type FROM types WHERE type = $ELEMENT")
  
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi

