class MovimentacoesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_movimentacao, only: %i[ destroy ]

  # GET /movimentacoes or /movimentacoes.json
  def index
    @movimentacoes = collection.order(data: :desc, created_at: :desc)
    @saldo = collection.saldo_atual
  end

  # GET /movimentacoes/new
  def new
    @movimentacao = collection.new
  end

  # POST /movimentacoes or /movimentacoes.json
  def create
    @movimentacao = collection.new(movimentacao_params)

    respond_to do |format|
      if @movimentacao.save
        format.html { redirect_to movimentacoes_url, notice: "A movimentação foi criada com sucesso." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movimentacoes/1 or /movimentacoes/1.json
  def destroy
    @movimentacao.destroy

    respond_to do |format|
      format.html { redirect_to movimentacoes_url, notice: "A movimentação foi removida com sucesso." }
      format.json { head :no_content }
    end
  end

  private

  def collection
    current_usuario.movimentacoes
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_movimentacao
    @movimentacao = collection.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def movimentacao_params
    params.require(:movimentacao).permit(:data, :descricao, :valor, :tipo)
  end
end
