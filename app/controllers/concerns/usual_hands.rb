module UsualHands
    extend ActiveSupport::Concern
    #文字列に変換
    StFl = "ストレートフラッシュ"
    FoC = "フォーカード"
    FulH = "フルハウス"
    Fl = "フラッシュ"
    St = "ストレート"
    ThC = "スリーカード"
    TwP  = "ツーカード"
    OnP = "ワンペア"
    HiC = "ハイカード"
    
    #受け取ったカードが正常かの確認
    #HDCS1-13＋半角スペースの文字列が５つ並んでいる
    def check_cards_five(cards)
        check = cards.match(/\A([HDSC]([1][0-3]|[1-9])\s){5}+$/)
        if check.nil?
            return false
        else
            return true
        end
    end
    
    #カードが重複していない
    def uniqueness_of_cards(cards)
        if cards.split().group_by.size != 5
            return false
        else
            return true
        end
    end
    
    #役の判定
    def judge_hands(cards)
        #受け取った要素を配列にいれグループ化して判断
        grouped_card = cards.split().group_by{|x| x.gsub(/[SHCD]/, "")}.map(&size).sort
        
        #組み合わせの数で役を判定、returnする
        case grouped_card
        when [1,1,1,1,1]
            if str_and_fla(cards)
                judgement = str_and_fla(cards)
            else
                judgement = Hic
            end
        when [1,1,1,2]
            judgement = OnP
        when [1,2,2]
            judgement = TwP
        when [1,4]
            judgement = FoC
        when [2,3]
            judgement = FulH
        when [3,1,1] 
            judgement = ThC
        end
        return judgement
    end
    
    #[1,1,1,1,1]時のストレートフラッシュの判定
    #ストレート
    def str(cards)
        #最大値から最小値の差が４（連続しない限り成立しえない）
        #K、１、２の組み合わせは不成立、Q,K、１は成立らしい（Wikipedia曰く）
        judge_str = cards.split().map{|x| x.gsub(/[HDSC]/,"").to_i}.max - cards.split().map{|x| x.gsub(/[HDSC]/,"").to_i}.min
        judge_str_ex = cards.split().map{|x| x.gsub(/[HDSC]/,"").to_i}.sort
        if judge_str == 4 || judge_str_ex == [1,10,11,12,13]
            return true
        end
    end
    
    #フラッシュ
    def fla(cards)
        #カードをアルファベット（スート）でグルーピングして判定
        judge_fla = cards.split().group_by{|x| x[0].chr}.size 
        if judge_fla == 1
            return true
        end
    end
    
    #上の２つが成り立つときストレートフラッシュが成り立つ
    #各々の役が成り立つ、もしくはハイカードの判定を委ねる
    def str_and_fla
        if str(cards) && fla(cards)
            judgement = StFl
            return judgement
        elsif str(cards)
            judgement = St
            return judgement
        elsif fla(cards)
            judgement = Fl
            return judgement
        else
            return false
        end
    end
        
end

