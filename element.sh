PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.

else
  element=$1
  if [[ $element =~ ^[0-9]+$ ]]
  then
    atomic_number=$element
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number=$atomic_number")
    symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$atomic_number")
    type=$($PSQL "SELECT type FROM types WHERE type_id=(SELECT type_id FROM properties WHERE atomic_number=$atomic_number)")
    mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$atomic_number")
    melting_point=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$atomic_number")
    boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$atomic_number")
  elif [[ $element =~ ^[A-Z]{1}[a-z]{0,1}$ ]]
  then
    symbol=$element
    name=$($PSQL "SELECT name FROM elements WHERE symbol='$symbol'")
    atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$symbol'")
    type=$($PSQL "SELECT type FROM types WHERE type_id=(SELECT type_id FROM properties WHERE atomic_number=$atomic_number)")
    mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$atomic_number")
    melting_point=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$atomic_number")
    boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$atomic_number")
  elif [[ $element =~ ^[A-Z][a-zA-Z]+$ ]]
  then 
    name=$element
    symbol=$($PSQL "SELECT symbol FROM elements WHERE name='$name'")
    atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE name='$name'")
    type=$($PSQL "SELECT type FROM types WHERE type_id=(SELECT type_id FROM properties WHERE atomic_number=$atomic_number)")
    mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$atomic_number")
    melting_point=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$atomic_number")
    boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$atomic_number")
  fi

  if [[ -z $name ]]
  then 
    echo I could not find that element in the database. 
  else
    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
  fi
fi 