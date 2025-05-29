class AdvancesController < ApplicationController
  def create
    @contract = Contract.find(params[:contract_id])
    @advance = @contract.advances.new(advance_params)
    
    if @advance.save
      ContractMailer.new_advance_notification(@advance).deliver_now
      redirect_to contract_path(@contract), notice: 'コメントを更新しました。'
    else
      render :new
    end
  end
  

  def edit
    @contract = Contract.find(params[:contract_id])
    @advance = Advance.find(params[:id])
    #@advance = @contract.advances.build
  end

	def destroy
		@contract = Contract.find(params[:contract_id])
		@advance = @contract.advances.find(params[:id])
		@advance.destroy
		redirect_to contract_path(@contract)
	end

  def update
    @contract = Contract.find(params[:contract_id])
    @advance = @contract.advances.find(params[:id])
    if @advance.update(advance_params)
       redirect_to contract_path(@contract)
    else
        render 'edit'
    end
  end

  private
  def advance_params
 	params.require(:advance).permit(
        :status,
        :next,
        :body,
    )
  end
end
