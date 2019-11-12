class HandsController < ApplicationController
    include UsualHands
    
    def index
    end
    
    def judge
        @cards = get_cards
        #入力された値の検証
        unless check_cards_five(@cards)
            flash.now[:notice] = "HDSCと1-13の組み合わせを半角スペースで挟んで５つ入力してください"
            render action: :index and return
        end
        
        #カードが重複していないかの検証
        unless uniqueness_of_cards(@cards)
            flash.now[:notice] = "カードが重複しています"
            render action: :index and return
        end
        
        #役の判定
        @judgement = judge_hands(@cards)
        render action: :index and return
        
        
    end
    
    private
    
    def get_cards
        params[:text]
    end
        
end
