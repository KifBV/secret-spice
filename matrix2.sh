#!/bin/ksh

# Functions and initialisations

# Katakana character set (almost) used in Matrix
katakana=(  ㄆ  ァ  ア  ィ  イ  ゥ  ウ  ェ  エ  ォ  オ  カ  ガ  キ  ギ  ク\
            グ  ケ  ゲ  コ  ゴ  サ  ザ  シ  ジ  ス  ズ  セ  ゼ  ソ  ゾ  タ\
            ダ  チ  ヂ  ッ  ツ  ヅ  テ  デ  ト  ド  ナ  ニ  ヌ  ネ  ノ  ハ\
            バ  パ  ヒ  ビ  ピ  フ  ブ  プ  ヘ  ベ  ペ  ホ  ボ  ポ  マ  ミ\
            ム  メ  モ  ャ  ヤ  ュ  ユ  ョ  ヨ  ラ  リ  ル  レ  ロ  ヮ  ワ\
            ヰ  ヱ  ヲ  ン  ヴ  ヵ  ヶ  ヷ  ヸ  ヹ  ヺ  ・  ー  ヽ  ヾ  ヿ)
# Welcome message
msg0=(C a l l \\040 t r a n s \\040 o p t : \\040 r e c e i v e d . \\040 9 - 1 8 - 9 9 \\040 1  4 : 3 2 : 2 1 \\040 R E C : L o g \>) 
msg1=(W A R N I N G : \\040 c a r r i e r \\040 a n o m a l y)
msg2=(T r a c e \\040 p r o g r a m :)
msg3=(\\040 r u n n i n g)

function printMessage {
typeset -n msg=$1   # Pas possible avec BASH
for char in ${msg[@]}; do
    printf "$char"
    sleep .05
    #usleep 50000
done
}

function printBanner {
    y_ref=$(( screen_width / 2 - 7 ))
    x_ref=$(( screen_height / 2 - 1 ))
    tput cup $x_ref $y_ref
    print "┏━━━━━━━━━━━━━━┓"
    tput cup $(( x_ref + 1 )) $y_ref
    print "┃SYSTEM FAILURE┃"
    tput cup $(( x_ref + 2 )) $y_ref
    print "┗━━━━━━━━━━━━━━┛"
}

# Change colors here
MC="\033[1;32m"     # Main Color
EC="\033[0;32m"     # Error Color
NOR="\033[0m"       # Normal

# Change rates here
char_rate=50        # 0..100
err_rate=15         # 0..100

disp_speed=500        # 1..∞ 

# Get screen size
screen_width=$(tput cols)
screen_height=$(tput lines)

# Debut du script

# Ajouter une intro ici

# Clean screen
tput clear; tput cup 0 0

# RAZ du terminal en quittant le script
trap 'printBanner; sleep 4; clear; tput sgr0; tput cnorm; exit' 1 2 3 15

printMessage msg0; sleep 3; clear
printMessage msg1; sleep 2; clear
printMessage msg2; sleep 1
printMessage msg3; sleep 1; clear

tput civis

while true; do
#col_index=0; while [[ $col_index -lt $(( screen_height )) ]]; do
    row_index=0; while [[ $row_index -lt $(( screen_width / 2 )) ]]; do
        n=$(( RANDOM%96 ))  # random nr [0-95]
        visible=$(( RANDOM%100 ))
        red=$(( RANDOM%100 ))
        if [[ $visible -gt $char_rate ]] then
            if [[ $red -lt $err_rate ]] then
                printf "${MC}${katakana[n]}"
            else
                printf "${EC}${katakana[n]}"
            fi 
        else
            printf "  "
        fi
        row_index=$(( row_index + 1 ))
    done
    sleep $(( 1 / ${disp_speed:=50} ))
    #usleep $(( 10000000 / ${disp_speed:=50} ))
    col_index=$(( col_index + 1 ))
done
