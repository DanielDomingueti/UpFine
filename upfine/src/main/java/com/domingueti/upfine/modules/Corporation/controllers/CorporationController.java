package com.domingueti.upfine.modules.Corporation.controllers;

import com.domingueti.upfine.modules.Corporation.dtos.CorporationDTO;
import com.domingueti.upfine.modules.Corporation.dtos.ChooseCorporationDTO;
import com.domingueti.upfine.modules.Corporation.repositories.CorporationRepository;
import com.domingueti.upfine.modules.Corporation.services.InsertDesiredCorporationsService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static java.util.stream.Collectors.toList;

@RestController
@RequestMapping("/corporations")
@AllArgsConstructor
public class CorporationController {

    final private CorporationRepository corporationRepository;

    final private InsertDesiredCorporationsService insertDesiredCorporationsService;

    @GetMapping
    public ResponseEntity<List<CorporationDTO>> findAll() {
        List<CorporationDTO> corporations = corporationRepository.findAll()
                .stream().map(CorporationDTO::new).collect(toList());

        return ResponseEntity.ok().body(corporations);
    }

    @PostMapping("/chosen")
    public ResponseEntity<Void> insertDesiredCorporations(@RequestBody ChooseCorporationDTO chooseCorporationDTO) {

        insertDesiredCorporationsService.execute(chooseCorporationDTO);

        return ResponseEntity.noContent().build();
    }

}
