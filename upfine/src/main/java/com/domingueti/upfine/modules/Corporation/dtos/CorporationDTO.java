package com.domingueti.upfine.modules.Corporation.dtos;

import com.domingueti.upfine.modules.Corporation.models.Corporation;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import static com.domingueti.upfine.utils.statics.ConvertCnpj.rawToFormatted;

@AllArgsConstructor
public class CorporationDTO {

    private @Getter @Setter Long id;

    private @Getter @Setter String cnpj;

    private @Getter @Setter String name;

    public CorporationDTO(Corporation corporation) {
        this.id = corporation.getId();
        this.cnpj = rawToFormatted(corporation.getCnpj());
        this.name = corporation.getName();
    }

}
