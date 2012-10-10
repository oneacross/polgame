class SpeakerController

  def initialize()
    @speakers = [
      {"wapo_api" => 3,"first_name" => "Chris","last_name"=>"Christie","party"=>"Republican","url"=>"http://www.state.nj.us/governor/library/photos/gov_christie.jpg","width"=>170,"height"=>242},
      {"wapo_api" => 5,"first_name" => "Clint","last_name"=>"Eastwood","party"=>"Republican","url"=>"http://www.newsmax.com/Newsmax/files/1a/1a81ded4-e973-42ee-9079-85da4547dada.jpg","width"=>170,"height"=>242},
      {"wapo_api" => 7,"first_name" => "Jim","last_name"=>"Lehrer","party"=>"","url"=>"http://www.pbs.org/newshour/aboutus/images/photo_bio_lehrer.jpg","width"=>170,"height"=>242},
      {"wapo_api" => 2,"first_name" => "Mitt","last_name"=>"Romney","party"=>"Republican","url"=>"http://reason.com/assets/mc/mriggs/MittRomneyProfilePic.jpg","width"=>521,"height"=>648},
      {"wapo_api" => 6,"first_name" => "Bill","last_name"=>"Clinton","party"=>"Democrat","url"=>"http://www.florencedailynews.com/wp-content/uploads/2012/09/bill-clinton-picture.jpg","width"=>170,"height"=>242},
      {"wapo_api" => 1,"first_name" => "Barack","last_name"=>"Obama","party"=>"Democrat","url"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/220px-Official_portrait_of_Barack_Obama.jpg","width"=>220,"height"=>299},
      {"wapo_api" => 4,"first_name" => "Paul","last_name"=>"Ryan","party"=>"Republican","url"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Paul_Ryan_official_portrait.jpg/220px-Paul_Ryan_official_portrait.jpg","width"=>170,"height"=>242}
    ]
  end

  def get_speaker(speaker_id)
    speaker = @speakers.select do |spkr|
      spkr['wapo_api'] == speaker_id.to_i
    end.first

    speaker['correct'] = true

    speaker
  end

  def get_wrong_speaker(speaker_id)
    speaker = @speakers.select do |spkr|
      spkr['wapo_api'] != speaker_id.to_i
    end.sample
  end

  # API
  def get_speaker_pair(quote)
    speaker_id = quote['speaker']['id']

    correct_speaker = get_speaker(speaker_id)
    wrong_speaker = get_wrong_speaker(speaker_id)

    return [correct_speaker, wrong_speaker].shuffle()
  end
end
