class Speaker

    def initialize(wapo_rsp)
      @wapo_id = wapo_rsp['id']
      @first_name = wapo_rsp['first_name']
      @last_name = wapo_rsp['last_name']
      @party = wapo_rsp['party']
    end

    def to_json()
      return {
        :wapo_api => @wapo_id,
        :first_name => @first_name,
        :last_name => @last_name,
        :party => @party
      }.to_json
    end
end
