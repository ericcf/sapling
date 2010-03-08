module Admin

  class WorkflowController < AdminController

    def update_state
      content_class = eval(params[:content_type])
      @content = content_class.find(params[:content_id])
      state = WorkflowState.find_by_name(params[:workflow_state])

      if @content.update_attribute(:workflow_state, state)
        flash[:notice] = 'Successfully changed content state.'
      else
        flash[:error] = 'Unable to change content state.'
      end

      redirect_to @content.path
    end
  end
end