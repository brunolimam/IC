def canibais_e_missionarios canibais_esquerda, missionarios_esquerda, margem_atual, canibais_direita, missionarios_direita, historico = [], resposta = []
	
	label = "#{canibais_esquerda},#{missionarios_esquerda},#{margem_atual},#{canibais_direita},#{missionarios_direita}"

	if historico.include?(label)
		puts "Estado já visitado (#{label})"
		return
	end

	historico << label

	if (canibais_esquerda > missionarios_esquerda && missionarios_esquerda != 0) || (canibais_direita > missionarios_direita && missionarios_direita > 0)
		puts "falhou, algum missionario morreu (#{label})"
		return
	else
		puts "*#{label}*"
		puts
	end

	resposta << label

	if canibais_esquerda == 3 && missionarios_esquerda == 3
		puts "Resposta: #{resposta}"
		exit
	end

	if margem_atual == "direita"
		proxima_margem = "esquerda"
		canibais = canibais_direita
		missionarios = missionarios_direita

	else
		proxima_margem = "direita"
		canibais = canibais_esquerda
		missionarios = missionarios_esquerda
	end

	proximos_passos = (0..canibais).to_a.product((0..missionarios).to_a).select{|array| array[0]+array[1] <= 2 && array[0]+array[1] != 0 }

	proximos_passos.each do |passo|
		# byebug

		puts "movendo #{passo[0]} canibais e #{passo[1]} missionarios para #{proxima_margem}"

		if margem_atual == "direita"
			canibais_e_missionarios canibais_esquerda+passo[0], missionarios_esquerda+passo[1], proxima_margem, canibais_direita-passo[0], missionarios_direita-passo[1], historico, resposta
		else
			canibais_e_missionarios canibais_esquerda-passo[0], missionarios_esquerda-passo[1], proxima_margem, canibais_direita+passo[0], missionarios_direita+passo[1], historico, resposta
		end

		puts "voltou para #{label}"
		puts
	end

	resposta.delete(label)

end

canibais_e_missionarios 0, 0, "direita", 3, 3