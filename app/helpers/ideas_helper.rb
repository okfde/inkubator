module IdeasHelper

  def status_check(status)
    if !status
      status = 'NEW'
    elsif status == 2
      status = 'First approval'
    else
      status = 'NO STATUS'
    end
  end

  def step_path(idea, step)
    return nil if idea.new_record?
    case step
    when 1
      idea_edit_mentor_path(idea)
    when 2
      idea_votes_path(idea)
    when 3
      idea_edit_finance_path(idea)
    when 4
      idea_edit_votes_finance_path(idea)
    else
      edit_idea_path(idea)
    end
  end

  def step_action(step)
    [:create, :edit_mentor, :edit_votes, :edit_finance, :edit_votes_finance][step]
  end

  def step_link(idea, step)
    classes = "button small round"
    if cannot?(step_action(step), idea) || (step >= idea.phase_index)
      classes << " disabled"
      link = false
    end
    if step == idea.phase_index - 1 and !idea.finished?
      classes << " alert"
    elsif  idea.finished?
      link = false
    end
    # checkx include toolti texts
    link_to t("#{Idea::PHASE[step]}"), (link != false ? step_path(idea, step) : '#'), "data-tooltip" => "", :class =>"has-tip", :title => t("tooltip_#{Idea::PHASE[step]}"), class: classes
  end

  def to_do_check(idea, step)
    return nil if idea.new_record?
    case step
    when 2
      if current_user == idea.user
        if idea.mentors.exists?
          return false
        else
          return true
        end
      end
    when 3
      !current_user.votings.where(idea_id: idea.id).exists?
    when 4
      if current_user == idea.user
        if idea.finance.present?
          return false
        else
          return true
        end
      end
    when 5
      #current_user.votings.where(idea_id: idea.id).where(finance: nil).exists?
    else
      return false
    end
  end

  def by_type_options
    [[t('helpers.idea.by_type.active'), 'active'],[t('helpers.idea.by_type.inactive'), 'inactive'],[t('helpers.idea.by_type.finished'),'finished']]
  end

  def order_options
    [[t('helpers.idea.order.date'), 'updated_at'],[t('helpers.idea.order.user'),'user']]
  end

  def by_phase_options
    [[t('helpers.idea.by_phase.all'), 'all'],[t('helpers.idea.by_phase.ideenskizze'),'ideenskizze'],[t('helpers.idea.by_phase.mentor'),'mentor'],[t('helpers.idea.by_phase.voting'), 'voting'],[t('helpers.idea.by_phase.finance'), 'finance'],[t('helpers.idea.by_phase.finance_voting'), 'finance_voting']]
  end

end
