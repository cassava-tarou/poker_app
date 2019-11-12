require 'rails_helper'

RSpec.describe HandsController, type: :controller do
    describe "#check" do
        
        context '正常な値を受け取ったとき' do
            context 'ストレートフラッシュ' do
                let(:cards) {"D1 D2 D3 D4 D5"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "ストレートフラッシュ"
                end
            end
            
            context 'フォーカード' do
                let(:cards) {"D1 H1 S1 C1 D2"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "フォーカード"
                end
            end
            
            context 'フルハウス' do
                let(:cards) {"D1 H1 D3 S3 C3"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "フルハウス"
                end
            end
            
            context 'フラッシュ' do
                let(:cards) {"D1 D2 D3 D4 D8"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "フルハウス"
                end
            end
            
            context 'ストレート' do
                let(:cards) {"D1 D2 D3 D4 H5"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "ストレート"
                end
            end
            
            context 'スリーカード' do
                let(:cards) {"D1 H1 C1 D4 D5"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "スリーカード"
                end
            end
            
            
            context 'ツーペア' do
                let(:cards) {"D1 H1 C4 D4 D5"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "ツーペア"
                end
            end
            
            context 'ワンペア' do
                let(:cards) {"D1 H1 C6 D4 D5"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "ワンペア"
                end
            end
            
            context 'ハイカード' do
                let(:cards) {"D1 H2 C7 D4 D5"}
                it '正しく判定を返す' do
                    expect(assigns(:judgement)).to_eq "ハイカード"
                end
            end
           
        end
    end

end
