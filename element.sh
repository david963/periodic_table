#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ELEMENT=$1
# if doesn't contain argument
if [[ -z $ELEMENT ]]
then
  echo Please provide an element as an argument.
else
  if [[ $ELEMENT =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $ELEMENT")
    SYMBOL=$($PSQL "SELECT symbol FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $ELEMENT OR name = '$ELEMENT' OR symbol = '$ELEMENT'")
    NAME=$($PSQL "SELECT name FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $ELEMENT OR name = '$ELEMENT' OR symbol = '$ELEMENT'")
      # if argument is not an element
      if [[ -z $ATOMIC_NUMBER ]] && [[ -z $SYMBOL ]] && [[ -z $NAME ]] 
      then
        echo "I could not find that element in the database."
      else
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $ELEMENT OR name = '$ELEMENT' OR symbol = '$ELEMENT'")
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $ELEMENT OR name = '$ELEMENT' OR symbol = '$ELEMENT'")
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $ELEMENT OR name = '$ELEMENT' OR symbol = '$ELEMENT'")
        TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number = $ELEMENT OR name = '$ELEMENT' OR symbol = '$ELEMENT'")

        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      fi
  else
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name = '$ELEMENT' OR symbol = '$ELEMENT'")
      SYMBOL=$($PSQL "SELECT symbol FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name = '$ELEMENT' OR symbol = '$ELEMENT'")
      NAME=$($PSQL "SELECT name FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name = '$ELEMENT' OR symbol = '$ELEMENT'")
        # if argument is not an element
        if [[ -z $ATOMIC_NUMBER ]] && [[ -z $SYMBOL ]] && [[ -z $NAME ]] 
        then
          echo "I could not find that element in the database."
        else
          ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name = '$ELEMENT' OR symbol = '$ELEMENT'")
          MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name = '$ELEMENT' OR symbol = '$ELEMENT'")
          BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name = '$ELEMENT' OR symbol = '$ELEMENT'")
          TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name = '$ELEMENT' OR symbol = '$ELEMENT'")

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        fi
  fi
  
fi

