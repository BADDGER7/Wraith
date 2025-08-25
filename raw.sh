#!/bin/bash

bash interface.sh

sleep 5

echo "============================="
echo "    |  ||▔| |▔| . ▔|▔ |_|    "
echo "    |/\||▔\ |▔| |  |  | |    "
echo "============================="

echo "          P. play            "
echo "          E. exit            "
echo "         C. credits          "

echo -n "==>"
read menu_choice

if [[ "$menu_choice" == "E" || "$menu_choice" == "e" ]]; then
    echo " exiting game......"
    sleep 5
    exit 0
elif [[ "$menu_choice" == "C" || "$menu_choice" == "c" ]]; then
	echo "============CREIDTS============ "
	echo "           Developers           "
	echo "       Parth Namdev Patil       "
	echo "           Perplexity           "
	echo "                                "
	echo "          Game Testers          "
	echo "          Vikram Singh          "
	echo "                                "
	echo "         Special Thanks         "
	echo "      Sukrut Namdev Patil       "
	echo "         Network Chunk          "
	echo "                                "
	echo "  Thanks for Playing this Game  "
	
elif [[ "$menu_choice" == "P" || "$menu_choice" == "p" ]]; then 

    echo "welcome to wraith"
    
    echo "Difficulty"
    echo "1. easy (1 boss)"
    echo "2. normal (3 boss)"
    echo "3. hard (5 boss)"
    
    echo -n "==>"
    read difficulty
    
    initial_player_health=25
    player_health=$initial_player_health
    player_lives=3

    all_bosses=("Pisher" "Spammer" "Cryptor" "Injector" "RootGroot")
    all_boss_healths=(30 35 40 45 50)
        
    case "$difficulty" in
        1)  boss_count=1 ;;
        2)  boss_count=3 ;;
        3)  boss_count=5 ;;
        *)  echo "Invalid difficulty selected." ; exit 1 ;;
    esac

    bosses=("${all_bosses[@]:0:$boss_count}")
    boss_healths=("${all_boss_healths[@]:0:$boss_count}")

    active_powerups=()
    attack_buff=0
    defense_buff=0
    dodge_moves_left=0
    boss_number=0
    echo "[A]==>Attack ++"
    echo "[D]==>Defense ++"
    echo "[H]==>Heal"
    echo "[S]==>Doege"
    grant_powerups() {
      if (( boss_number > 1 )); then
        local possible_powerups=("A" "D" "H" "S")
        for _ in {1..2}; do
          if (( ${#active_powerups[@]} < 2 )); then
            new_pu=${possible_powerups[$RANDOM % ${#possible_powerups[@]}]}
            if [[ ! " ${active_powerups[*]} " =~ " $new_pu " ]]; then
              active_powerups+=("$new_pu")
              echo "You gained a power-up: $new_pu"
            fi
          fi
        done
      fi
    }

    use_powerup() {
      if (( ${#active_powerups[@]} == 0 )); then
        echo "No power-ups available."
        return
      fi

      echo "Active Power-ups: ${active_powerups[*]}"
      echo -n "Type power-up name to use or press Enter to skip: "
      read choice

      if [[ " ${active_powerups[*]} " =~ " $choice " ]]; then
        echo "Using power-up: $choice"
        case "$choice" in
          A)
            attack_buff=$((5 + RANDOM % 21))
            echo "Attack increased by $attack_buff% for this fight."
            ;;
          D)
            defense_buff=50
            echo "Boss damage reduced by 50% for this fight."
            ;;
          H)
            heal_points=$((5 + RANDOM % 11))
            player_health=$((player_health + heal_points))
            echo "You healed $heal_points HP. Current health: $player_health"
            ;;
          S)
            dodge_moves_left=2
            echo "You will dodge the next 2 boss moves."
            ;;
          *)
            echo "Power-up not recognized."
            ;;
        esac

        # Remove used power-up
        for i in "${!active_powerups[@]}"; do
          if [[ "${active_powerups[i]}" == "$choice" ]]; then
            unset 'active_powerups[i]'
            break
          fi
        done
        active_powerups=("${active_powerups[@]}")  # re-index
      else
        echo "No power-up used."
      fi
    }

    grant_powerup_after_quiz() {
      if (( ${#active_powerups[@]} < 2 )); then
        local powerup_pool=("A" "D" "H" "S")
        for _ in {1..2}; do
          if (( ${#active_powerups[@]} < 2 )); then
            new_pu=${powerup_pool[$RANDOM % ${#powerup_pool[@]}]}
            if [[ ! " ${active_powerups[*]} " =~ " $new_pu " ]]; then
              active_powerups+=("$new_pu")
              echo "Power-up granted as quiz reward: $new_pu"
            fi
          fi
        done
      else
        echo "Power-up slots full, no quiz reward added."
      fi
    }

    for i in "${!bosses[@]}"; do
        boss_number=$(( boss_number + 1 ))
        current_boss="${bosses[$i]}"
        boss_health="${boss_healths[$i]}"
        
        attack_buff=0
        defense_buff=0
        dodge_moves_left=0
        
        echo "[F]==>light hit"
        echo "[R]==>heavy hit"
        echo "[E]==>dodge hit"
        
        echo "======================================="
        echo "New battle: $current_boss"
        echo "======================================="
        
        grant_powerups
        
        while true; do
            echo "======================================="
            echo "Malware Knight : $current_boss"
            echo "Boss HP : $boss_health "
            echo "DEV HP : $player_health | Lives : $player_lives"
            echo "======================================="
            
            use_powerup
            
            echo -n "==>"
            read action
            
            damage=0
            if [[ "$action" == "F" || "$action" == "f" ]]; then
                if (( RANDOM % 100 < 70 )); then
                    base_damage=2
                    damage=$(( base_damage + (base_damage * attack_buff / 100) ))
                    echo -n "DEV: "
                    echo "damage + ($damage)"
                    (( boss_health -= damage ))
                else
                    echo "missed"
                fi
            elif [[ "$action" == "R" || "$action" == "r" ]]; then
                if (( RANDOM % 100 < 50 )); then
                    base_damage=4
                    damage=$(( base_damage + (base_damage * attack_buff / 100) ))
                    echo "damage ++ ($damage)"
                    (( boss_health -= damage ))
                else
                    echo "missed"
                fi
            elif [[ "$action" == "E" || "$action" == "e" ]]; then
                if (( RANDOM % 100 < 85 )); then
                    echo "dodged"
                else
                    echo "you are hit"
                fi
            else
                echo "Invalid attack choice."
            fi
            
            if (( boss_health <= 0 )); then
                echo "You defeated the boss! Victory!"
                
                bash powerups.sh
                quiz_result=$?

                if [[ $quiz_result -eq 0 ]]; then
                    echo "Correct answer! Granting power-ups..."
                    grant_powerup_after_quiz
                else
                    echo "Wrong answer! No power-ups granted."
                fi
                
                break
            fi
            
            if (( RANDOM % 100 < 60 )); then
                echo "Boss attacks!"
                if (( dodge_moves_left > 0 )); then
                  echo "You dodged the boss's attack!"
                  (( dodge_moves_left-- ))
                else
                  boss_damage=2
                  reduced_damage=$(( boss_damage - (boss_damage * defense_buff / 100) ))
                  (( player_health -= reduced_damage ))
                  echo "You got hit for $reduced_damage damage."
                fi
                
                if (( player_health <= 0 )); then
                    ((player_lives--))
                    if (( player_lives > 0 )); then
                        echo "============================================="
                        echo "You lost a life! Lives left: $player_lives"
                        player_health=$initial_player_health
                        echo "Restoring your health to $player_health."
                        sleep 1
                        echo "==============================================="
                        
                    else
                        echo "      GAME OVER        "
                        break 2
                    fi
                fi

            else
                echo "Boss missed!"
            fi
        done
    done
fi
