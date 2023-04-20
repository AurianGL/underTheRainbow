# Purpose: To store the tree data structure to plan a trip to Berlin
# each item represnent a set of choices which each are assiciated with a symbol

TREE = {
    "1. Go to Berlin" => {
        "1.1. What is the date of your trip ?" => {
            "1. 6-7-8 mai" => :date,
            "2. 13-14 mai" => :date,
            "3. 18-19-20-21 mai" => :date,
            "4. 27 mai and beyond" => :date,
            '5. I don\'t know yet' => :date,
            '6. pas en mai' => :date
        },
        "What type of activities do you want to do ?" => {
            "1. Eat, Pray, Love" => :act,
            "2. 48h berghain" => :act,
            "3. I don't know, I'll just follow" => :act,
        } ,
        "What type of places do you want to visit ?" => {
            "1. Museum" => :place,
            "2. Bars" => :place,
            "3. Clubs" => :place,
            "4. I don't know, I'll just follow" => :place,
        },
        "make suggestions" => :suggestions,
        "show choices" => :show_choices,
        "Stop that monstruosity" => :stop,
    },
    "2. NØ" => :exit
}