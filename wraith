#!/bin/bash

# === Color Codes ===
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

clear
bash interface.sh

sleep 5

echo -e "${CYAN}============================="
echo "    |  ||▔| |▔| . ▔|▔ |_|    "
echo "    |/\||▔\ |▔| |  |  | |    "
echo -e "=============================${RESET}"

echo -e "${YELLOW}          P. play            "
echo -e "          E. exit            "
echo -e "          C. credits          ${RESET}"

echo -en "${YELLOW}==> ${RESET}"
read menu_choice

if [[ "$menu_choice" == "E" || "$menu_choice" == "e" ]]; then
    echo -e "${RED} exiting game......${RESET}"
    sleep 5
    exit 0
elif [[ "$menu_choice" == "C" || "$menu_choice" == "c" ]]; then
    echo -e "${YELLOW}============CREDITS============${RESET}"
    echo -e "${WHITE}           Developers           "
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
    echo "  Thanks for Playing this Game  ${RESET}"

elif [[ "$menu_choice" == "P" || "$menu_choice" == "p" ]]; then 

    echo -e "${WHITE}welcome to wraith${RESET}"
    	MAGENTA="\033[0;35m"
	RESET="\033[0m"

	echo -e "${MAGENTA}In the shadows of the digital world, a silent war rages...${RESET}"
	sleep 3
	echo -e "${MAGENTA}Malicious code and malware knights threaten the integrity of the network.${RESET}"
	sleep 3
	echo -e "${MAGENTA}You are the Malware Knight—guardian of the WRAITH cyber realm.${RESET}"
	sleep 3
	echo -e "${MAGENTA}Your mission: eliminate the rogue malware bosses corrupting the system.${RESET}"
	sleep 3
	echo -e "${MAGENTA}Each defeated malware strengthens your tools and defenses.${RESET}"
	sleep 3
	echo -e "${MAGENTA}But beware—the final enemy, the RootGroot, awaits in the heart of the network.${RESET}"
	sleep 3
	echo -e "${MAGENTA}Prepare your arsenal, sharpen your skills, and prove your mastery.${RESET}"
	sleep 3
	echo -e "${MAGENTA}The fate of the network depends on your battle prowess and knowledge.${RESET}"
	sleep 3
	echo -e "${MAGENTA}Will you rise as the ultimate Malware Knight and secure WRAITH?${RESET}"
	sleep 3
	echo -e "${MAGENTA}Your quest begins now...${RESET}"
	sleep 3

    
    echo -e "${YELLOW}Difficulty${RESET}"
    echo -e "${YELLOW}1. easy (1 boss)${RESET}"
    echo -e "${YELLOW}2. normal (3 boss)${RESET}"
    echo -e "${YELLOW}3. hard (5 boss)${RESET}"
    
    echo -en "${YELLOW}==> ${RESET}"
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
        *)  echo -e "${RED}Invalid difficulty selected.${RESET}" ; exit 1 ;;
    esac

    bosses=("${all_bosses[@]:0:$boss_count}")
    boss_healths=("${all_boss_healths[@]:0:$boss_count}")

    active_powerups=()
    attack_buff=0
    defense_buff=0
    dodge_moves_left=0
    boss_number=0

    echo -e "${CYAN}[A]==>Attack ++"
    echo -e "[D]==>Defense ++"
    echo -e "[H]==>Heal"
    echo -e "[S]==>Dodge${RESET}"

    grant_powerups() {
      if (( boss_number > 1 )); then
        local possible_powerups=("A" "D" "H" "S")
        for _ in {1..2}; do
          if (( ${#active_powerups[@]} < 2 )); then
            new_pu=${possible_powerups[$RANDOM % ${#possible_powerups[@]}]}
            if [[ ! " ${active_powerups[*]} " =~ " $new_pu " ]]; then
              active_powerups+=("$new_pu")
              echo -e "${YELLOW}You gained a power-up: $new_pu${RESET}"
            fi
          fi
        done
      fi
    }

    use_powerup() {
      if (( ${#active_powerups[@]} == 0 )); then
        echo -e "${WHITE}No power-ups available.${RESET}"
        return
      fi

      PS3="$(echo -e "${YELLOW}Select power-up to use (number) or press Enter to skip: ${RESET}")"
      select choice in "${active_powerups[@]}" "Skip"; do
        if [[ -z "$REPLY" || "$REPLY" -gt $((${#active_powerups[@]} + 1)) ]]; then
          echo -e "${WHITE}Skipping power-up use.${RESET}"
          break
        elif [[ "$choice" == "Skip" ]]; then
          echo -e "${WHITE}Skipping power-up use.${RESET}"
          break
        elif [[ -n "$choice" ]]; then
          echo -e "${YELLOW}Using power-up: $choice${RESET}"
          case "$choice" in
            A)
              attack_buff=$((5 + RANDOM % 21))
              echo -e "${GREEN}Attack increased by $attack_buff% for this fight.${RESET}"
              ;;
            D)
              defense_buff=50
              echo -e "${GREEN}Boss damage reduced by 50% for this fight.${RESET}"
              ;;
            H)
              heal_points=$((5 + RANDOM % 11))
              player_health=$((player_health + heal_points))
              echo -e "${GREEN}You healed $heal_points HP. Current health: $player_health${RESET}"
              ;;
            S)
              dodge_moves_left=2
              echo -e "${GREEN}You will dodge the next 2 boss moves.${RESET}"
              ;;
            *)
              echo -e "${RED}Invalid choice.${RESET}"
              ;;
          esac

          # Remove used power-up
          for i in "${!active_powerups[@]}"; do
            if [[ "${active_powerups[i]}" == "$choice" ]]; then
              unset 'active_powerups[i]'
              break
            fi
          done
          active_powerups=("${active_powerups[@]}")  # reindex array
          break
        else
          echo -e "${RED}Invalid choice, try again.${RESET}"
        fi
      done
    }

    grant_powerup_after_quiz() {
      if (( ${#active_powerups[@]} < 2 )); then
        local powerup_pool=("A" "D" "H" "S")
        for _ in {1..2}; do
          if (( ${#active_powerups[@]} < 2 )); then
            new_pu=${powerup_pool[$RANDOM % ${#powerup_pool[@]}]}
            if [[ ! " ${active_powerups[*]} " =~ " $new_pu " ]]; then
              active_powerups+=("$new_pu")
              echo -e "${YELLOW}Power-up granted as quiz reward: $new_pu${RESET}"
            fi
          fi
        done
      else
        echo -e "${WHITE}Power-up slots full, no quiz reward added.${RESET}"
      fi
    }

    for i in "${!bosses[@]}"; do
        boss_number=$(( boss_number + 1 ))
        current_boss="${bosses[$i]}"
        boss_health="${boss_healths[$i]}"
        
        attack_buff=0
        defense_buff=0
        dodge_moves_left=0
        
        echo -e "${YELLOW}[F]==>light hit"
        echo -e "[R]==>heavy hit"
        echo -e "[E]==>dodge hit${RESET}"
        
        echo -e "${CYAN}======================================="
        echo -e "New battle: $current_boss"
        echo -e "=======================================${RESET}"
        
        grant_powerups
        
        while true; do
            echo -e "${CYAN}======================================="
            echo -e "Malware Knight : $current_boss"
            echo -e "${RED}Boss HP : $boss_health "
            echo -e "${GREEN}DEV HP : $player_health | ${RED}Lives : $player_lives"
            echo -e "${CYAN}=======================================${RESET}"
            
            use_powerup
            
            echo -en "${YELLOW}==> ${RESET}"
            read action
            
            damage=0
            if [[ "$action" == "F" || "$action" == "f" ]]; then
                if (( RANDOM % 100 < 70 )); then
                    base_damage=2
                    damage=$(( base_damage + (base_damage * attack_buff / 100) ))
                    echo -e "${GREEN}DEV: damage + ($damage)${RESET}"
                    (( boss_health -= damage ))
                else
                    echo -e "${RED}missed${RESET}"
                fi
            elif [[ "$action" == "R" || "$action" == "r" ]]; then
                if (( RANDOM % 100 < 50 )); then
                    base_damage=4
                    damage=$(( base_damage + (base_damage * attack_buff / 100) ))
                    echo -e "${GREEN}damage ++ ($damage)${RESET}"
                    (( boss_health -= damage ))
                else
                    echo -e "${RED}missed${RESET}"
                fi
            elif [[ "$action" == "E" || "$action" == "e" ]]; then
                if (( RANDOM % 100 < 85 )); then
                    echo -e "${GREEN}dodged${RESET}"
                else
                    echo -e "${RED}you are hit${RESET}"
                fi
            else
                echo -e "${RED}Invalid attack choice.${RESET}"
            fi
            
            if (( boss_health <= 0 )); then
                echo -e "${GREEN}You defeated the boss! Victory!${RESET}"
                
                bash powerups.sh
                quiz_result=$?
                
                if [[ $quiz_result -eq 0 ]]; then
                    echo -e "${GREEN}Correct answer! Granting power-ups...${RESET}"
                    grant_powerup_after_quiz
                else
                    echo -e "${RED}Wrong answer! No power-ups granted.${RESET}"
                fi
                
                break
            fi
            
            if (( RANDOM % 100 < 60 )); then
                echo -e "${RED}Boss attacks!${RESET}"
                if (( dodge_moves_left > 0 )); then
                  echo -e "${YELLOW}You dodged the boss's attack!${RESET}"
                  (( dodge_moves_left-- ))
                else
                  boss_damage=2
                  reduced_damage=$(( boss_damage - (boss_damage * defense_buff / 100) ))
                  (( player_health -= reduced_damage ))
                  echo -e "${RED}You got hit for $reduced_damage damage.${RESET}"
                fi
                
                if (( player_health <= 0 )); then
                    ((player_lives--))
                    if (( player_lives > 0 )); then
                        echo -e "${YELLOW}============================================="
                        echo -e "You lost a life! Lives left: $player_lives"
                        player_health=$initial_player_health
                        echo -e "Restoring your health to $player_health."
                        sleep 1
                        echo -e "===============================================${RESET}"
                    else
                        echo -e "${RED}............................................................................... .................${RESET}"
                        echo -e "${RED}..._______   ________   ___    ___   _______      ________   ___      ___   _______   ________ ..${RESET}"
                        echo -e "${RED}..|  _____| |   __   | |    \/    | |  ==== |    |   __   | |   |    |   | |  ==== | |   __   |..${RESET}"
                        echo -e "${RED}..|  |  __  |  |__|  | |  |\  /|  | |  _____|    |  |  |  |  \   \  /   /  |  _____| |  |__|  |..${RESET}"
                        echo -e "${RED}..|  |_|  | |   __   | |  | \/ |  | | |_____     |  |__|  |   \   \/   /   | |_____  |   __   |..${RESET}"
                        echo -e "${RED}..|_______| |__|  |__| |__|    |__| |_______|    |________|    \______/    |_______| |__|  \__\..${RESET}"
                        echo -e "${RED}............................................................................... .................${RESET}"
                        break 2
                    fi
                fi
                
            else
                echo -e "${WHITE}Boss missed!${RESET}"
            fi
        done
    done
fi
